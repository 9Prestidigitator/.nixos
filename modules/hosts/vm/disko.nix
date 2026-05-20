{inputs, ...}: {
  flake.diskoConfigurations.vm = {
    imports = [inputs.disko.nixosModules.disko];
    disko.devices = {
      nodev."/" = {
        fsType = "tmpfs";
        mountOptions = [
          "size=25%"
          "mode=755"
        ];
      };

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
                mountOptions = ["umask=0077"];
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
                  extraArgs = ["-f" "-L" "nixos"];

                  subvolumes = {
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
