{
  config,
  ...
}: {
  programs.niri.settings.binds = with config.lib.niri.actions; {
    "Mod+Home".action = focus-column-first;
    "Mod+End".action = focus-column-last;

    "Mod+Left".action = focus-column-left;
    "Mod+Right".action = focus-column-right;
    "Mod+Up".action = focus-window-up;
    "Mod+Down".action = focus-window-down;

    "Mod+H".action = focus-column-left;
    "Mod+L".action = focus-column-right;
    "Mod+K".action = focus-window-or-workspace-up;
    "Mod+J".action = focus-window-or-workspace-down;

    "Mod+Shift+Left".action = focus-monitor-left;
    "Mod+Shift+Right".action = focus-monitor-right;
    "Mod+Shift+Up".action = focus-monitor-up;
    "Mod+Shift+Down".action = focus-monitor-down;
    "Mod+Shift+H".action = focus-monitor-left;
    "Mod+Shift+L".action = focus-monitor-right;
    "Mod+Shift+K".action = focus-monitor-up;
    "Mod+Shift+J".action = focus-monitor-down;

    "Mod+Q" = {
      hotkey-overlay.title = "Quit window";
      action = close-window;
    };

    "Mod+O" = {
      hotkey-overlay.title = "Show overview";
      action = toggle-overview;
    };

    "Mod+Page_Up".action = focus-workspace-up;
    "Mod+U".action = focus-workspace-up;
    "Mod+Page_Down".action = focus-workspace-down;
    "Mod+D".action = focus-workspace-down;

    "Mod+WheelScrollLeft".action = focus-column-left;
    "Mod+WheelScrollRight".action = focus-column-right;
    "Mod+WheelScrollUp" = {
      cooldown-ms = 120;
      action = focus-workspace-up;
    };
    "Mod+WheelScrollDown" = {
      cooldown-ms = 120;
      action = focus-workspace-down;
    };

    "Mod+Tab".action = focus-workspace-previous;

    "Mod+1".action.focus-workspace = 1;
    "Mod+2".action.focus-workspace = 2;
    "Mod+3".action.focus-workspace = 3;
    "Mod+4".action.focus-workspace = 4;
    "Mod+5".action.focus-workspace = 5;
    "Mod+6".action.focus-workspace = 6;
    "Mod+7".action.focus-workspace = 7;
    "Mod+8".action.focus-workspace = 8;
    "Mod+9".action.focus-workspace = 9;

    "Mod+Shift+Slash" = {
      hotkey-overlay.title = "Show this hotkey overlay";
      action = show-hotkey-overlay;
    };
  };
}
