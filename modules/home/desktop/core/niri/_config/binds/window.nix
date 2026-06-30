{
  config,
  mkWlrWhichKeyMenu,
  ...
}: {
  programs.niri.settings.binds = with config.lib.niri.actions; {
    "Mod+W".action.spawn = mkWlrWhichKeyMenu "Window State" [
      {
        key = "e";
        desc = "Toggle window floating/tiling state";
        cmd = "niri msg action toggle-window-floating";
      }
      {
        key = "f";
        desc = "Fullscreen window";
        cmd = "niri msg action fullscreen-window";
      }
      {
        key = "F";
        desc = "Stretch window edges to edges";
        cmd = "niri msg action maximize-window-to-edges";
      }
      {
        key = "m";
        desc = "Maximize current window";
        cmd = "niri msg action maximize-column";
      }
      {
        key = "M";
        desc = "Expand column to available width";
        cmd = "niri msg action expand-column-to-available-width";
      }
      {
        key = "r";
        desc = "Reset current window height";
        cmd = "niri msg action reset-window-height";
      }
      {
        key = "s";
        desc = "Toggle sticky floating window";
        cmd = "niri-float-sticky -ipc toggle_sticky";
      }
      {
        key = "t";
        desc = "Toggle Column Tabbed Display";
        cmd = "niri msg action toggle-column-tabbed-display";
      }
      {
        key = "w";
        desc = "Switch focus between floating and tiling";
        cmd = "niri msg action switch-focus-between-floating-and-tiling";
      }
    ];

    "Mod+R".action = switch-preset-column-width-back;
    "Mod+Shift+R".action = switch-preset-window-height;

    "Mod+F".action = maximize-window-to-edges;
    "Mod+Shift+F".action = fullscreen-window;

    "Mod+Ctrl+Space".action = toggle-window-floating;

    "Mod+Minus".action.set-column-width = "-10%";
    "Mod+Equal".action.set-column-width = "+10%";

    "Mod+Shift+Minus".action.set-window-height = "-10%";
    "Mod+Shift+Equal".action.set-window-height = "+10%";
  };
}
