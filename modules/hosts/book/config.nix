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
      homeModules.noctalia-5

      homeModules.neovim
      homeModules.terminal-tools

      homeModules.stylix
    ];
    users.users.max.hashedPasswordFile = "/persist/passwds/max";

    impermanence.btrfs.rollbackRoot.enable = true;

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

    services.keyd = {
      enable = true;
      keyboards.default = {
        settings = {
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
            up = "pageup";
            down = "pagedown";
          };
          shift.backspace = "delete";
        };
      };
    };

    system.stateVersion = "26.05";
    home-manager.sharedModules = [{home.stateVersion = "26.05";}];
  };
}
