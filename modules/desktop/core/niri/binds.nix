{
  config,
  inputs,
  lib,
  osConfig,
  ...
}: {
  programs.niri.settings.binds = with config.lib.niri.actions;
    lib.mkMerge [
      {
        "Mod+Shift+Slash" = {
          hotkey-overlay.title = "Show this hotkey overlay";
          action = show-hotkey-overlay;
        };

        "Mod+Q" = {
          hotkey-overlay.title = "Quit window";
          action = close-window;
        };

        "Mod+O" = {
          hotkey-overlay.title = "Show overview";
          action = toggle-overview;
        };

        # Quick launch applications
        "Mod+Return" = {
          hotkey-overlay.title = "Launch terminal: Kitty";
          action = spawn "kitty";
        };
        "Mod+B" = {
          hotkey-overlay.title = "Launch browser: Browser";
          action = spawn "brave";
        };
        "Mod+E" = {
          hotkey-overlay.title = "Launch explorer: Nautilus";
          action = spawn "nautilus" "-w";
        };
        "Mod+N" = {
          hotkey-overlay.title = "Launch text editor: Neovim";
          action = spawn "kitty" "--title" "Neovim" "-e" "nvim";
        };
        "Mod+T" = {
          hotkey-overlay.title = "Launch tmux";
          action = spawn "kitty" "--title" "tmux" "bash" "-lc" "tmux a || tmux";
        };
        "Ctrl+Shift+Escape" = {
          hotkey-overlay.title = "btop";
          action = spawn "kitty" "--title" "'btop'" "-e" "btop";
        };

        # noctalia-shell binds
        "Mod+Escape" = {
          hotkey-overlay.title = "Lock";
          allow-when-locked = true;
          action = spawn "noctalia-shell" "ipc" "call" "lockScreen" "lock";
        };
        "Mod+Space" = {
          hotkey-overlay.title = "Toggle launcher";
          action = spawn "noctalia-shell" "ipc" "call" "launcher" "toggle";
        };
        "Mod+Shift+I" = {
          hotkey-overlay.title = "Toggle idle inhibitor";
          action = spawn "noctalia-shell" "ipc" "call" "idleInhibitor" "toggle";
        };
        "Mod+Shift+D" = {
          hotkey-overlay.title = "Toggle dashboard";
          action = spawn "noctalia-shell" "ipc" "call" "controlCenter" "toggle";
        };
        "Mod+Shift+N" = {
          hotkey-overlay.title = "Show notifications";
          action = spawn "noctalia-shell" "ipc" "call" "notifications" "toggleHistory";
        };
        "Mod+Shift+B" = {
          hotkey-overlay.title = "Toggle Noctalia bar";
          action = spawn "noctalia-shell" "ipc" "call" "bar" "toggle";
        };

        # System keys
        "XF86AudioPlay" = {
          hotkey-overlay.hidden = true;
          allow-when-locked = true;
          action = spawn "playerctl" "play-pause";
        };
        "XF86AudioPause" = {
          hotkey-overlay.hidden = true;
          allow-when-locked = true;
          action = spawn "playerctl" "play-pause";
        };
        "XF86AudioNext" = {
          hotkey-overlay.hidden = true;
          allow-when-locked = true;
          action = spawn "playerctl" "next";
        };
        "XF86AudioPrev" = {
          hotkey-overlay.hidden = true;
          allow-when-locked = true;
          action = spawn "playerctl" "previous";
        };
        "XF86AudioRaiseVolume" = {
          hotkey-overlay.hidden = true;
          allow-when-locked = true;
          action = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1+";
        };
        "XF86AudioLowerVolume" = {
          hotkey-overlay.hidden = true;
          allow-when-locked = true;
          action = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1-";
        };
        "XF86AudioMute" = {
          hotkey-overlay.hidden = true;
          allow-when-locked = true;
          action = spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle";
        };
        "XF86AudioMicMute" = {
          hotkey-overlay.hidden = true;
          allow-when-locked = true;
          action = spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle";
        };
        "XF86MonBrightnessUp" = {
          hotkey-overlay.hidden = true;
          allow-when-locked = true;
          action = spawn "brightnessctl" "--class=backlight" "set" "+5%";
        };
        "XF86MonBrightnessDown" = {
          hotkey-overlay.hidden = true;
          allow-when-locked = true;
          action = spawn "brightnessctl" "--class=backlight" "set" "5%-";
        };

        "Mod+Left".action = focus-column-left;
        "Mod+Down".action = focus-window-down;
        "Mod+Up".action = focus-window-up;
        "Mod+Right".action = focus-column-right;
        "Mod+H".action = focus-column-left;
        # "Mod+J".action = focus-window-down;
        # "Mod+K".action = focus-window-up;
        "Mod+L".action = focus-column-right;

        "Mod+Ctrl+Left".action = move-column-left;
        "Mod+Ctrl+Down".action = move-window-down;
        "Mod+Ctrl+Up".action = move-window-up;
        "Mod+Ctrl+Right".action = move-column-right;
        "Mod+Ctrl+H".action = move-column-left;
        # "Mod+Ctrl+J".action = move-window-down;
        # "Mod+Ctrl+K".action = move-window-up;
        "Mod+Ctrl+L".action = move-column-right;

        "Mod+J".action = focus-window-or-workspace-down;
        "Mod+K".action = focus-window-or-workspace-up;
        "Mod+Ctrl+J".action = move-window-down-or-to-workspace-down;
        "Mod+Ctrl+K".action = move-window-up-or-to-workspace-up;

        "Mod+Home".action = focus-column-first;
        "Mod+End".action = focus-column-last;
        "Mod+Ctrl+Home".action = move-column-to-first;
        "Mod+Ctrl+End".action = move-column-to-last;

        "Mod+Shift+Left".action = focus-monitor-left;
        "Mod+Shift+Down".action = focus-monitor-down;
        "Mod+Shift+Up".action = focus-monitor-up;
        "Mod+Shift+Right".action = focus-monitor-right;
        "Mod+Shift+H".action = focus-monitor-left;
        "Mod+Shift+J".action = focus-monitor-down;
        "Mod+Shift+K".action = focus-monitor-up;
        "Mod+Shift+L".action = focus-monitor-right;

        "Mod+Shift+Ctrl+Left".action = move-column-to-monitor-left;
        "Mod+Shift+Ctrl+Down".action = move-column-to-monitor-down;
        "Mod+Shift+Ctrl+Up".action = move-column-to-monitor-up;
        "Mod+Shift+Ctrl+Right".action = move-column-to-monitor-right;
        "Mod+Shift+Ctrl+H".action = move-column-to-monitor-left;
        "Mod+Shift+Ctrl+J".action = move-column-to-monitor-down;
        "Mod+Shift+Ctrl+K".action = move-column-to-monitor-up;
        "Mod+Shift+Ctrl+L".action = move-column-to-monitor-right;

        # "Mod+Alt+H".action = move-workspace-to-monitor-left;
        # "Mod+Alt+J".action = move-workspace-to-monitor-down;
        # "Mod+Alt+K".action = move-workspace-to-monitor-up;
        # "Mod+Alt+L".action = move-workspace-to-monitor-right;

        "Mod+Page_Down".action = focus-workspace-down;
        "Mod+Page_Up".action = focus-workspace-up;
        "Mod+D".action = focus-workspace-down;
        "Mod+U".action = focus-workspace-up;
        "Mod+Ctrl+Page_Down".action = move-column-to-workspace-down;
        "Mod+Ctrl+Page_Up".action = move-column-to-workspace-up;
        "Mod+Ctrl+D".action = move-column-to-workspace-down;
        "Mod+Ctrl+U".action = move-column-to-workspace-up;

        "Mod+Shift+Page_Down".action = move-workspace-down;
        "Mod+Shift+Page_Up".action = move-workspace-up;
        "Mod+Alt+D".action = move-workspace-down;
        "Mod+Alt+U".action = move-workspace-up;
        "Mod+Alt+J".action = move-workspace-down;
        "Mod+Alt+K".action = move-workspace-up;

        "Mod+WheelScrollUp" = {
          cooldown-ms = 150;
          action = focus-workspace-up;
        };
        "Mod+WheelScrollDown" = {
          cooldown-ms = 150;
          action = focus-workspace-down;
        };
        "Mod+Ctrl+WheelScrollUp" = {
          cooldown-ms = 150;
          action = move-column-to-workspace-up;
        };
        "Mod+Ctrl+WheelScrollDown" = {
          cooldown-ms = 150;
          action = move-column-to-workspace-down;
        };

        "Mod+WheelScrollRight".action = focus-column-right;
        "Mod+WheelScrollLeft".action = focus-column-left;
        "Mod+Ctrl+WheelScrollRight".action = move-column-right;
        "Mod+Ctrl+WheelScrollLeft".action = move-column-left;

        "Mod+1".action.focus-workspace = 1;
        "Mod+2".action.focus-workspace = 2;
        "Mod+3".action.focus-workspace = 3;
        "Mod+4".action.focus-workspace = 4;
        "Mod+5".action.focus-workspace = 5;
        "Mod+6".action.focus-workspace = 6;
        "Mod+7".action.focus-workspace = 7;
        "Mod+8".action.focus-workspace = 8;
        "Mod+9".action.focus-workspace = 9;
        "Mod+Ctrl+1".action.move-column-to-workspace = 1;
        "Mod+Ctrl+2".action.move-column-to-workspace = 2;
        "Mod+Ctrl+3".action.move-column-to-workspace = 3;
        "Mod+Ctrl+4".action.move-column-to-workspace = 4;
        "Mod+Ctrl+5".action.move-column-to-workspace = 5;
        "Mod+Ctrl+6".action.move-column-to-workspace = 6;
        "Mod+Ctrl+7".action.move-column-to-workspace = 7;
        "Mod+Ctrl+8".action.move-column-to-workspace = 8;
        "Mod+Ctrl+9".action.move-column-to-workspace = 9;

        "Mod+Tab".action = focus-workspace-previous;
        "Mod+BracketLeft".action = consume-or-expel-window-left;
        "Mod+BracketRight".action = consume-or-expel-window-right;

        "Mod+Comma".action = consume-window-into-column;
        "Mod+Period".action = expel-window-from-column;

        "Mod+R".action = switch-preset-column-width-back;
        "Mod+Shift+R".action = switch-preset-window-height;

        "Mod+Ctrl+R".action = reset-window-height;
        "Mod+M".action = maximize-column;

        "Mod+F".action = fullscreen-window;
        "Mod+Ctrl+F".action = maximize-window-to-edges;
        "Mod+Shift+F".action = expand-column-to-available-width;

        "Mod+C".action = center-column;
        "Mod+Shift+C".action = center-visible-columns;

        "Mod+Ctrl+Space".action = toggle-window-floating;
        "Mod+G".action = switch-focus-between-floating-and-tiling;

        # Finer width adjustments.
        # This command can also:
        # * set width in pixels: "1000"
        # * adjust width in pixels: "-5" or "+5"
        # * set width as a percentage of screen width: "25%"
        # * adjust width as a percentage of screen width: "-10%" or "+10%"
        # Pixel sizes use logical, or scaled, pixels. I.e. on an output with scale 2.0,
        # set-column-width = "100" will make the column occupy 200 physical screen pixels.
        "Mod+Minus".action.set-column-width = "-10%";
        "Mod+Equal".action.set-column-width = "+10%";

        # Finer height adjustments when in column with other windows.
        "Mod+Shift+Minus".action.set-window-height = "-10%";
        "Mod+Shift+Equal".action.set-window-height = "+10%";

        "Mod+W".action = toggle-column-tabbed-display;

        # Take an area screenshot. Select the area to screenshot with mouse
        "Print".action.screenshot = {show-pointer = false;};
        # Take a screenshot of the focused monitor
        "Ctrl+Print".action.screenshot-screen = {write-to-disk = true;};
        # Take a screenshot of the focused window
        "Alt+Print".action.screenshot-window = [];

        "Ctrl+Alt+Delete" = {
          hotkey-overlay.title = "Logout";
          action.quit.skip-confirmation = false;
        };
        "Mod+Alt+Delete" = {
          hotkey-overlay.title = "Session Options";
          action = spawn "noctalia-shell" "ipc" "call" "sessionMenu" "toggle";
        };

        "Mod+Shift+P".action = power-off-monitors;

        # This debug bind will tint all surfaces green, unless they are being
        # directly scanned out. It's therefore useful to check if direct scanout
        # is working.
        # (plain "Mod+Shift+Ctrl+T" [(flag "toggle-debug-tint")])
      }
      (lib.mkIf (osConfig.networking.hostName == "surface") {
        "XF86PowerOff" = {
          allow-when-locked = true;
          action = spawn "niri" "msg" "action" "power-off-monitors";
        };
      })
    ];
}
