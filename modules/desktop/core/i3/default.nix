{
  lib,
  config,
  inputs,
  pkgs,
  ...
}: let
  cfg = config.desktop;
  isI3 = cfg.enable && cfg.mode == "i3";
in {
  config = lib.mkIf isI3 {
    services.displayManager.ly = {
      enable = true;
      settings = {
        allow_empty_password = false;
        animation = "matrix";
        bigclock = "en";
        clock = "%c";
        lang = "en";
        numlock = true;
        vi_default_mode = "insert";
        vi_mode = true;
      };
    };

    services.xserver = {
      enable = true;
      windowManager.i3 = {
        enable = true;
        extraPackages = with pkgs; [
          dmenu
          i3status
          i3lock
          picom
        ];
      };
    };

    xdg.portal = {
      enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
      ];
    };

    home-manager.sharedModules = [
      {
        xsession.windowManager.i3 = {
          config = {
            modifier = "Mod4";
            terminal = "kitty";

            gaps = {
              inner = 10;
              outer = 5;
            };

            keybindings = {
              "Mod4+Return" = "exec kitty";
              "Mod4+d" = "exec dmenu_run";
              "Mod4+Shift+q" = "kill";
              "Mod4+Shift+r" = "restart";
            };

            startup = [
              {
                command = "picom";
                always = true;
              }
              {command = "nm-applet";}
            ];
          };
        };
      }
    ];
  };
}
