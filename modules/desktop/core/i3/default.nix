{
  lib,
  config,
  inputs,
  pkgs,
  ...
}: let
  cfg = config.desktop;
  isI3 = cfg.enable && cfg.x11WM == "i3";
in {
  config = lib.mkIf isI3 {
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
              "Mod4+space" = "exec dmenu_run";
              "Mod4+q" = "kill";
              "Mod4+Shift+r" = "restart";

              "Mod4+Control+space" = "floating toggle";
              "Mod4+f" = "fullscreen toggle";

              "Mod4+r" = "mode resize";

              "Mod4+u" = "workspace prev";
              "Mod4+d" = "workspace next";

              "Mod4+Shift+h" = "focus output left";
              "Mod4+Shift+l" = "focus output right";
              "Mod4+Control+Shift+l" = "move container to workspace next_on_output";
              "Mod4+Control+Shift+h" = "move container to workspace prev_on_output";

              "Mod4+h" = "focus left";
              "Mod4+j" = "focus down";
              "Mod4+k" = "focus up";
              "Mod4+l" = "focus right";
              "Mod4+Control+h" = "move left";
              "Mod4+Control+j" = "move down";
              "Mod4+Control+k" = "move up";
              "Mod4+Control+l" = "move right";

              "Mod4+Alt+h" = "move workspace to output left";
              "Mod4+Alt+l" = "move workspace to output right";
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
