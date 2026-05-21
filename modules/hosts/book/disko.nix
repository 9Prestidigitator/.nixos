{inputs, ...}: {
  flake.diskoConfigurations.book = {pkgs, ...}: {
    imports = [inputs.disko.nixosModules.disko];

    fileSystems."/".neededForBoot = true;
    fileSystems."/nix".neededForBoot = true;
    fileSystems."/persist".neededForBoot = true;

    boot.initrd.systemd.services.rollback-root = {
      description = "Rollback Btrfs root subvolume";
      wantedBy = ["initrd.target"];
      # Must happen after LUKS root is opened, but before / is mounted.
      after = ["systemd-cryptsetup@crypted\\x2droot.service"];
      before = ["sysroot.mount"];

      unitConfig.DefaultDependencies = "no";
      serviceConfig = {
        Type = "oneshot";
      };
      path = [
        pkgs.btrfs-progs
        pkgs.coreutils
        pkgs.findutils
        pkgs.gnused
        pkgs.util-linux
      ];

      script = ''
        mkdir -p /btrfs_tmp
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

        if [[ -d /btrfs_tmp/old_roots ]]; then
          for old_root in $(find /btrfs_tmp/old_roots -mindepth 1 -maxdepth 1 -mtime +30); do
            delete_subvolume_recursively "$old_root"
          done
        fi

        btrfs subvolume create /btrfs_tmp/@root
        umount /btrfs_tmp
      '';
    };

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
