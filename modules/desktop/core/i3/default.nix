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
    services.displayManager.defaultSession = "none+i3";

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
