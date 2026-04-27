{
  config,
  mkWlrWhichKeyMenu,
  ...
}: {
  programs.niri.settings.binds = with config.lib.niri.actions; {
    "Mod+W".action.spawn = mkWlrWhichKeyMenu "Window State" [
      {
        key = "w";
        desc = "Switch focus between floating and tiling";
        cmd = "niri msg action switch-focus-between-floating-and-tiling";
      }
      {
        key = "t";
        desc = "Toggle Column Tabbed Display";
        cmd = "niri msg action toggle-column-tabbed-display";
      }
      {
        key = "z";
        desc = "Center current window";
        cmd = "niri msg action center-column";
      }
      {
        key = "Z";
        desc = "Center visible columns";
        cmd = "niri msg action center-visible-columns";
      }
      {
        key = "f";
        desc = "Fullscreen window";
        cmd = "niri msg action fullscreen-window";
      }
      {
        key = "r";
        desc = "Reset current window height";
        cmd = "niri msg action reset-window-height";
      }
      {
        key = "m";
        desc = "Toggle maximize current window";
        cmd = "niri msg action maximize-column";
      }
    ];

    "Mod+R".action = switch-preset-column-width-back;
    "Mod+Shift+R".action = switch-preset-window-height;

    "Mod+F".action = maximize-window-to-edges;
    "Mod+Shift+F".action = expand-column-to-available-width;

    "Mod+Ctrl+Space".action = toggle-window-floating;

    "Mod+Minus".action.set-column-width = "-10%";
    "Mod+Equal".action.set-column-width = "+10%";

    "Mod+Shift+Minus".action.set-window-height = "-10%";
    "Mod+Shift+Equal".action.set-window-height = "+10%";
  };
}
