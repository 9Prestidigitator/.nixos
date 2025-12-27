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
          xrandr
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
          enable = true;
          config = {
            modifier = "Mod4";
            terminal = "kitty";

            gaps = {
              inner = 10;
              outer = 5;
            };

            keybindings = {
              "Mod4+Return" = "exec kitty";
              "Mod4+Space" = "exec dmenu_run";
              "Mod4+q" = "kill";
              "Mod4+Shift+r" = "restart";

              "Mod4+Control+space" = "floating toggle";
              "Mod4+f" = "fullscreen toggle";

              "Mod4+r" = "mode resize";

              "Mod4+h" = "focus left";
              "Mod4+j" = "focus down";
              "Mod4+k" = "focus up";
              "Mod4+l" = "focus right";
              "Mod4+Shift+h" = "move left";
              "Mod4+Shift+j" = "move down";
              "Mod4+Shift+k" = "move up";
              "Mod4+Shift+l" = "move right";
            };

            modes = {
              resize = {
                "h" = "resize shrink width 10 px or 10 ppt";
                "j" = "resize grow height 10 px or 10 ppt";
                "k" = "resize shrink height 10 px or 10 ppt";
                "l" = "resize grow width 10 px or 10 ppt";

                "Escape" = "mode default";
                "Return" = "mode default";
              };
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
