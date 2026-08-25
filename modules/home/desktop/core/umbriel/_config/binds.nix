{mkWlrWhichKeyMenuWith, ...}: let
  msg = cmd: "noctalia msg ${cmd}";
  spawn = cmd: "spawn:${cmd}";
in {
  programs.umbriel = {
    settings = {
      keybinds = {
        "Mod+Return" = "spawn:kitty";

        "Mod+Left" = "window-focus-left";
        "Mod+Right" = "window-focus-right";
        "Mod+Up" = "window-focus-up";
        "Mod+Down" = "window-focus-down";

        "Mod+H" = "window-focus-left";
        "Mod+L" = "window-focus-right";
        "Mod+K" = "window-focus-up";
        "Mod+J" = "window-focus-down";

        "Mod+Q" = "window-close";
        "Mod+O" = "overview-toggle";
        "Mod+Ctrl+Space" = "window-toggle-floating";
        "Mod+F" = "window-toggle-maximize-to-edges";
        "Mod+Shift+F" = "window-toggle-fullscreen";
        "Mod+R" = "window-cycle-width";

        "Mod+Minus" = "window-modify-width:-0.1";
        "Mod+Equal" = "window-modify-width:0.1";
        "Mod+Shift+Minus" = "window-modify-height:-0.1";
        "Mod+Shift+Equal" = "window-modify-height:0.1";

        "Mod+PageUp" = "workspace-previous";
        "Mod+U" = "workspace-previous";
        "Mod+PageDown" = "workspace-next";
        "Mod+D" = "workspace-next";

        "Mod+WheelUp" = "workspace-previous";
        "Mod+WheelDown" = "workspace-next";

        "Mod+1" = "workspace-switch:1";
        "Mod+2" = "workspace-switch:2";
        "Mod+3" = "workspace-switch:3";
        "Mod+4" = "workspace-switch:4";
        "Mod+5" = "workspace-switch:5";
        "Mod+6" = "workspace-switch:6";
        "Mod+7" = "workspace-switch:7";
        "Mod+8" = "workspace-switch:8";
        "Mod+9" = "workspace-switch:9";

        "Mod+Ctrl+Left" = "column-move-left";
        "Mod+Ctrl+Right" = "column-move-right";
        "Mod+Ctrl+Up" = "window-move-up";
        "Mod+Ctrl+Down" = "window-move-down";

        "Mod+Ctrl+H" = "column-move-left";
        "Mod+Ctrl+L" = "column-move-right";
        "Mod+Ctrl+K" = "window-move-up";
        "Mod+Ctrl+J" = "window-move-down";

        "Mod+Ctrl+PageUp" = "window-move-to-workspace-previous";
        "Mod+Ctrl+U" = "window-move-to-workspace-previous";
        "Mod+Ctrl+PageDown" = "window-move-to-workspace-next";
        "Mod+Ctrl+D" = "window-move-to-workspace-next";

        "Mod+Ctrl+1" = "window-move-to-workspace:1";
        "Mod+Ctrl+2" = "window-move-to-workspace:2";
        "Mod+Ctrl+3" = "window-move-to-workspace:3";
        "Mod+Ctrl+4" = "window-move-to-workspace:4";
        "Mod+Ctrl+5" = "window-move-to-workspace:5";
        "Mod+Ctrl+6" = "window-move-to-workspace:6";
        "Mod+Ctrl+7" = "window-move-to-workspace:7";
        "Mod+Ctrl+8" = "window-move-to-workspace:8";
        "Mod+Ctrl+9" = "window-move-to-workspace:9";

        "Mod+Shift+H" = "output-focus-left";
        "Mod+Shift+L" = "output-focus-right";
        "Mod+Shift+K" = "output-focus-up";
        "Mod+Shift+J" = "output-focus-down";

        "Mod+Shift+Ctrl+H" = "column-move-to-output-left";
        "Mod+Shift+Ctrl+L" = "column-move-to-output-right";
        "Mod+Shift+Ctrl+K" = "column-move-to-output-up";
        "Mod+Shift+Ctrl+J" = "column-move-to-output-down";

        "Mod+Alt+H" = "workspace-move-to-output-left";
        "Mod+Alt+L" = "workspace-move-to-output-right";
        "Mod+Alt+K" = "workspace-move-to-output-up";
        "Mod+Alt+J" = "workspace-move-to-output-down";

        "Mod+Shift+Slash" = "cheatsheet-toggle";
        "Mod+Shift+P" = "dpms-off";
        "Ctrl+Alt+Delete" = "session-quit";
      };
    };
  };
}
