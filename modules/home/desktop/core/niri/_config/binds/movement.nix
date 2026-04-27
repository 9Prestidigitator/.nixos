{
  config,
  mkWlrWhichKeyMenu,
  ...
}: {
  programs.niri.settings.binds = with config.lib.niri.actions; {
    "Mod+Ctrl+Home".action = move-column-to-first;
    "Mod+Ctrl+End".action = move-column-to-last;

    "Mod+Shift+Ctrl+Left".action = move-column-to-monitor-left;
    "Mod+Shift+Ctrl+Right".action = move-column-to-monitor-right;
    "Mod+Shift+Ctrl+Up".action = move-column-to-monitor-up;
    "Mod+Shift+Ctrl+Down".action = move-column-to-monitor-down;

    "Mod+Shift+Ctrl+H".action = move-column-to-monitor-left;
    "Mod+Shift+Ctrl+L".action = move-column-to-monitor-right;
    "Mod+Shift+Ctrl+K".action = move-column-to-monitor-up;
    "Mod+Shift+Ctrl+J".action = move-column-to-monitor-down;

    "Mod+Ctrl+H".action = move-column-left;
    "Mod+Ctrl+L".action = move-column-right;
    "Mod+Ctrl+K".action = move-window-up-or-to-workspace-up;
    "Mod+Ctrl+J".action = move-window-down-or-to-workspace-down;

    "Mod+Ctrl+Left".action = move-column-left;
    "Mod+Ctrl+Right".action = move-column-right;
    "Mod+Ctrl+Up".action = move-window-up;
    "Mod+Ctrl+Down".action = move-window-down;

    "Mod+Ctrl+Page_Down".action = move-column-to-workspace-down;
    "Mod+Ctrl+Page_Up".action = move-column-to-workspace-up;
    "Mod+Ctrl+D".action = move-column-to-workspace-down;
    "Mod+Ctrl+U".action = move-column-to-workspace-up;

    "Mod+Shift+Page_Down".action = move-workspace-down;
    "Mod+Shift+Page_Up".action = move-workspace-up;

    "Mod+Alt+H".action = move-workspace-to-monitor-left;
    "Mod+Alt+L".action = move-workspace-to-monitor-right;
    "Mod+Alt+K".action = move-workspace-up;
    "Mod+Alt+J".action = move-workspace-down;

    "Mod+Alt+D".action = move-workspace-down;
    "Mod+Alt+U".action = move-workspace-up;

    "Mod+Ctrl+WheelScrollUp" = {
      cooldown-ms = 120;
      action = move-column-to-workspace-up;
    };
    "Mod+Ctrl+WheelScrollDown" = {
      cooldown-ms = 120;
      action = move-column-to-workspace-down;
    };

    "Mod+Ctrl+WheelScrollRight".action = move-column-right;
    "Mod+Ctrl+WheelScrollLeft".action = move-column-left;

    "Mod+Ctrl+1".action.move-column-to-workspace = 1;
    "Mod+Ctrl+2".action.move-column-to-workspace = 2;
    "Mod+Ctrl+3".action.move-column-to-workspace = 3;
    "Mod+Ctrl+4".action.move-column-to-workspace = 4;
    "Mod+Ctrl+5".action.move-column-to-workspace = 5;
    "Mod+Ctrl+6".action.move-column-to-workspace = 6;
    "Mod+Ctrl+7".action.move-column-to-workspace = 7;
    "Mod+Ctrl+8".action.move-column-to-workspace = 8;
    "Mod+Ctrl+9".action.move-column-to-workspace = 9;

    "Mod+M".action.spawn = mkWlrWhichKeyMenu "Move Window" [
      {
        key = "w";
        desc = "Move Workspace";
        submenu = [
          {
            key = "j";
            desc = "Move workspace down";
            cmd = "niri msg action move-workspace-down";
          }
          {
            key = "k";
            desc = "Move workspace up";
            cmd = "niri msg action move-workspace-up";
          }
          {
            key = "h";
            desc = "Move workspace to monitor on left";
            cmd = "niri msg action move-workspace-to-monitor-left";
          }
          {
            key = "l";
            desc = "Move workspace to monitor on right";
            cmd = "niri msg action move-workspace-to-monitor-right";
          }
          {
            key = "J";
            desc = "Move workspace to monitor below";
            cmd = "niri msg action move-workspace-to-monitor-down";
          }
          {
            key = "K";
            desc = "Move workspace to monitor above";
            cmd = "niri msg action move-workspace-to-monitor-up";
          }
        ];
      }
      {
        key = "g";
        desc = "Move window furthest left position";
        cmd = "niri msg action move-column-to-first";
      }
      {
        key = "G";
        desc = "Move window furthest right position";
        cmd = "niri msg action move-column-to-last";
      }
      {
        key = "h";
        desc = "Consume or Expel window left";
        cmd = "niri msg action consume-or-expel-window-left";
      }
      {
        key = "H";
        desc = "Move column left";
        cmd = "niri msg action move-column-left";
      }
      {
        key = "j";
        desc = "Consume window into column";
        cmd = "niri msg action consume-window-into-column";
      }
      {
        key = "k";
        desc = "Expel window from column";
        cmd = "niri msg action expel-window-from-column";
      }
      {
        key = "l";
        desc = "Consume or Expel window right";
        cmd = "niri msg action consume-or-expel-window-right";
      }
      {
        key = "L";
        desc = "Move column right";
        cmd = "niri msg action move-column-right";
      }
      {
        key = "1";
        desc = "Move column to workspace 1";
        cmd = "niri msg action move-column-to-workspace 1";
      }
      {
        key = "2";
        desc = "Move column to workspace 2";
        cmd = "niri msg action move-column-to-workspace 2";
      }
      {
        key = "3";
        desc = "Move column to workspace 3";
        cmd = "niri msg action move-column-to-workspace 3";
      }
      {
        key = "4";
        desc = "Move column to workspace 4";
        cmd = "niri msg action move-column-to-workspace 4";
      }
      {
        key = "5";
        desc = "Move column to workspace 5";
        cmd = "niri msg action move-column-to-workspace 5";
      }
      {
        key = "6";
        desc = "Move column to workspace 6";
        cmd = "niri msg action move-column-to-workspace 6";
      }
      {
        key = "7";
        desc = "Move column to workspace 7";
        cmd = "niri msg action move-column-to-workspace 7";
      }
      {
        key = "8";
        desc = "Move column to workspace 8";
        cmd = "niri msg action move-column-to-workspace 8";
      }
      {
        key = "9";
        desc = "Move column to workspace 9";
        cmd = "niri msg action move-column-to-workspace 9";
      }
      {
        key = "0";
        desc = "Move column to workspace 10";
        cmd = "niri msg action move-column-to-workspace 10";
      }
    ];
  };
}
