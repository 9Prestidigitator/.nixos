{
  inputs,
  self,
  ...
}: {
  flake = {
    nixosConfigurations.book = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = with self.nixosModules; [
        max

        ly
        niri
        noctalia

        essentials
        brave-browser

        terminal-tools
        mullvad

        build-machines
        stylix

        sops
        grub
        system-general
        home-manager
        nix

        book
      ];
    };

    nixosModules.book = {
      host = {
        name = "book";
        isLaptop = true;
      };

      home-manager = {
        users.max = {
          imports = with self.homeModules; [
            max

            niri
            noctalia

            neovim
            terminal-tools

            stylix
          ];
        };
      };

      boot.kernelPatches = [
        {
          name = "chrultrabook-stoney-audio";
          patch = inputs.stoney-kernel + "/patches/audio.patch";
        }
      ];

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

      services.keyd = {
        keyboards.default = {
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
      };
    };
  };
}
