{
  self,
  inputs,
  ...
}: {
  flake.hostModules.book = {pkgs, ...}: {
    host.name = "book";

    home-manager.users.max.imports = with self; [
      userModules.max.homeModule

      homeModules.niri

      homeModules.neovim
      homeModules.terminal-tools

      homeModules.stylix
    ];

    users.users = {
      root.initialPassword = "nixos";
      max.initialPassword = "nixos";
    };

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

    boot = {
      kernelPackages = pkgs.linuxPackages_6_12;
      kernelPatches = [
        {
          name = "chrultrabook-stoney-audio";
          patch = inputs.stoney-kernel + "/patches/audio.patch";
        }
      ];
    };

    services.blueman.enable = true;

    fileSystems."/mnt/SD" = {
      device = "/dev/disk/by-label/SD";
      fsType = "exfat";
      options = [
        "nofail"
        "x-systemd.automount"
        "uid=1000"
        "gid=100"
        "umask=0022"
      ];
    };

    services.keyd.keyboards.default = {
      settings = {
        main = {
          mouse2 = "leftmeta";
          mouse1 = "esc";
          capslock = "overload(mod5, esc)";
        };
        mod5 = {
          h = "left";
          j = "down";
          k = "up";
          l = "right";
          u = "pageup";
          d = "pagedown";
          backspace = "delete";
        };
        "shift:S" = {
          capslock = "capslock";
        };
        "mod5+shift" = {
          g = "end";
        };

        main = {
          f1 = "back";
          f2 = "forward";
          f3 = "refresh";
          f4 = "print";
          f5 = "A-tab";
          f6 = "brightnessdown";
          f7 = "brightnessup";
          f8 = "mute";
          f9 = "volumedown";
          f10 = "volumeup";
        };

        # Allow F1-10 access through meta+fnX
        meta = {
          f1 = "f1";
          f2 = "f2";
          f3 = "f3";
          f4 = "f4";
          f5 = "f5";
          f6 = "f6";
          f7 = "f7";
          f8 = "f8";
          f9 = "f9";
          f10 = "f10";
        };

        # Allow TTY access
        "control+alt" = {
          f1 = "C-A-f1";
          f2 = "C-A-f2";
          f3 = "C-A-f3";
          f4 = "C-A-f4";
          f5 = "C-A-f5";
          f6 = "C-A-f6";
          f7 = "C-A-f7";
          f8 = "C-A-f8";
          f9 = "C-A-f9";
          f10 = "C-A-f10";
          left = "home";
          right = "end";
        };

        "control+alt" = {
          up = "home";
          down = "end";
        };

        "alt" = {
          backspace = "delete";
          up = "pageup";
          down = "pagedown";
        };
      };
    };

    system.stateVersion = "26.05";
    home-manager.sharedModules = [{home.stateVersion = "26.05";}];
  };
}
