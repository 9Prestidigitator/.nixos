{
  flake.homeModules.sway = {
    config,
    lib,
    osConfig,
    ...
  }: {
    wayland.windowManager.sway = {
      enable = true;
      package = osConfig.programs.sway.package;
      systemd.enable = true;

      config = rec {
        modifier = "Mod4";
        terminal =
          if config.desktop.terminal.name == null
          then "foot"
          else config.desktop.terminal.name;
        menu = "noctalia msg panel-toggle launcher";

        left = "h";
        down = "j";
        up = "k";
        right = "l";

        bars = [];

        gaps = {
          inner = 10;
          outer = 5;
        };

        window = {
          border = 2;
          titlebar = false;
        };

        floating = {
          border = 2;
          titlebar = false;
        };

        input."type:touchpad" = {
          tap = "enabled";
          natural_scroll = "enabled";
          dwt = "enabled";
        };

        seat."*".hide_cursor = "when-typing enable";

        keybindings = lib.mkOptionDefault {
          "${modifier}+Return" = "exec ${terminal}";
          "${modifier}+space" = "exec ${menu}";
          "${modifier}+Escape" = "exec noctalia msg session lock";
          "${modifier}+q" = "kill";
          "${modifier}+Shift+r" = "reload";
          "Control+Alt+Delete" = "exec noctalia msg panel-toggle session";
          "Print" = "exec noctalia msg screenshot-region";
          "Shift+Print" = "exec noctalia msg screenshot-fullscreen";

          "${modifier}+h" = "focus left";
          "${modifier}+j" = "focus down";
          "${modifier}+k" = "focus up";
          "${modifier}+l" = "focus right";
          "${modifier}+Shift+h" = "move left";
          "${modifier}+Shift+j" = "move down";
          "${modifier}+Shift+k" = "move up";
          "${modifier}+Shift+l" = "move right";

          "${modifier}+Control+h" = "focus output left";
          "${modifier}+Control+j" = "focus output down";
          "${modifier}+Control+k" = "focus output up";
          "${modifier}+Control+l" = "focus output right";
          "${modifier}+Control+Shift+h" = "move workspace to output left";
          "${modifier}+Control+Shift+j" = "move workspace to output down";
          "${modifier}+Control+Shift+k" = "move workspace to output up";
          "${modifier}+Control+Shift+l" = "move workspace to output right";

          "${modifier}+u" = "workspace prev";
          "${modifier}+d" = "workspace next";
          "${modifier}+Tab" = "workspace back_and_forth";
          "${modifier}+m" = "mode move";
          "${modifier}+r" = "mode resize";
        };

        modes = {
          move = {
            h = "move left";
            j = "move down";
            k = "move up";
            l = "move right";
            Escape = "mode default";
            Return = "mode default";
          };

          resize = {
            h = "resize shrink width 10 px";
            j = "resize grow height 10 px";
            k = "resize shrink height 10 px";
            l = "resize grow width 10 px";
            Escape = "mode default";
            Return = "mode default";
          };
        };
      };
    };
  };
}
