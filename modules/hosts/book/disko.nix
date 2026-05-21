{inputs, ...}: {
  flake.diskoConfigurations.book = {lib, ...}: {
    imports = [inputs.disko.nixosModules.disko];

    fileSystems."/".neededForBoot = true;
    fileSystems."/nix".neededForBoot = true;
    fileSystems."/persist".neededForBoot = true;

    boot.initrd.postResumeCommands = lib.mkAfter ''
      mkdir /btrfs_tmp
      mount -t btrfs -o subvolid=5 /dev/mapper/crypted-root /btrfs_tmp

      if [[ -e /btrfs_tmp/@root ]]; then
        mkdir -p /btrfs_tmp/old_roots
        timestamp="$(date --date="@$(stat -c %Y /btrfs_tmp/@root)" "+%Y-%m-%d_%H:%M:%S")"
        mv /btrfs_tmp/@root "/btrfs_tmp/old_roots/$timestamp"
      fi

      delete_subvolume_recursively() {
        IFS=$'\n'
        for subvolume in $(btrfs subvolume list -o "$1" | cut -f 9- -d ' '); do
          delete_subvolume_recursively "/btrfs_tmp/$subvolume"
        done
        btrfs subvolume delete "$1"
      }

      for old_root in $(find /btrfs_tmp/old_roots/ -mindepth 1 -maxdepth 1 -mtime +30 2>/dev/null || true); do
        delete_subvolume_recursively "$old_root"
      done

      btrfs subvolume create /btrfs_tmp/@root
      umount /btrfs_tmp
    '';

    disko.devices = {
      disk.main = {
        device = "/dev/vda";
        type = "disk";

        content = {
          type = "gpt";

          partitions = {
            boot = {
              name = "boot";
              size = "1M";
              type = "EF02";
            };

            esp = {
              name = "ESP";
              size = "1G";
              type = "EF00";

              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [
                  "umask=0077"
                ];
              };
            };

            swap = {
              name = "swap";
              size = "2G";
              content = {
                type = "luks";
                name = "crypted-swap";
                settings.allowDiscards = true;
                content = {
                  type = "swap";
                  resumeDevice = true;
                };
              };
            };

            root = {
              name = "root";
              size = "100%";
              content = {
                type = "luks";
                name = "crypted-root";
                settings.allowDiscards = true;
                content = {
                  type = "btrfs";
                  extraArgs = [
                    "-f"
                    "-L"
                    "nixos"
                  ];
                  subvolumes = {
                    "@root" = {
                      mountpoint = "/";
                      mountOptions = [
                        "compress=zstd"
                        "noatime"
                      ];
                    };
                    "@nix" = {
                      mountpoint = "/nix";
                      mountOptions = [
                        "compress=zstd"
                        "noatime"
                      ];
                    };
                    "@persist" = {
                      mountpoint = "/persist";
                      mountOptions = [
                        "compress=zstd"
                        "noatime"
                      ];
                    };
                    "@log" = {
                      mountpoint = "/var/log";
                      mountOptions = [
                        "compress=zstd"
                        "noatime"
                      ];
                    };
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}
