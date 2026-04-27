{
  flake.nixosModules.i3 = {pkgs, ...}: {
    services = {
      xserver = {
        enable = true;
        windowManager.i3 = {
          enable = true;
          extraPackages = with pkgs; [
            dmenu
            i3status
            i3lock
            picom
            xrandr
            scrot
            xclip
            feh
          ];
        };
        xrandrHeads = [
          {
            output = "eDP-1";
            primary = true;
          }
        ];
      };
      picom = {
        enable = true;
        backend = "egl";
        vSync = true;
        settings = {
          unredir-if-possible = false;
          use-damage = false;
        };
      };
    };

    xdg.portal = {
      enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
      ];
    };
  };
}
