{
  inputs,
  config,
  lib,
  mkWlrWhichKeyMenu,
  ...
}: let
  noctalia = cmd: "noctalia-shell ipc call ${cmd}";
in {
  imports = [inputs.self.homeModules.wlr-which-key];
  programs.niri.settings.binds = with config.lib.niri.actions; {
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

    # Launch applications
    "Mod+Return" = {
      hotkey-overlay.title = "Launch terminal (Kitty)";
      action = spawn "kitty";
    };

    "Mod+G".action.spawn = mkWlrWhichKeyMenu "Applications" [
      {
        key = "b";
        desc = "Browser (Brave)";
        cmd = "brave";
      }
      {
        key = "e";
        desc = "Explorer (Nautilus)";
        cmd = "nautilus -w";
      }
      {
        key = "n";
        desc = "Text Editor (Neovim)";
        cmd = "kitty --title Neovim -e nvim";
      }
      {
        key = "N";
        desc = "Open Notes";
        cmd = "kitty --title Notes -e sh -c 'cd ~/notes && nix develop -c sh -c nvim'";
      }
      {
        key = "t";
        desc = "tmux";
        cmd = "kitty --title tmux bash -lc 'tmux a || tmux'";
      }
      {
        key = "s";
        desc = "Spotify";
        cmd = "spotify";
      }
      {
        key = "m";
        desc = "Bitwig";
        cmd = "bitwig-studio";
      }
      {
        key = "j";
        desc = "qpwgraph";
        cmd = "qpwgraph";
      }
      {
        key = "J";
        desc = "QJackCtl";
        cmd = "qjackctl";
      }
      {
        key = "i";
        desc = "Moonlight";
        cmd = "moonlight";
      }
      {
        key = "y";
        desc = "Steam";
        cmd = "steam";
      }
      {
        key = "d";
        desc = "Discord";
        cmd = "discord";
      }
    ];

    "Mod+N".action.spawn = mkWlrWhichKeyMenu "Noctalia" [
      {
        key = "p";
        desc = "Plugin panels";
        submenu = [
          {
            key = "a";
            desc = "Assistant Panel";
            cmd = noctalia "plugin openPanel assistant-panel";
          }
          {
            key = "p";
            desc = "Privacy";
            cmd = noctalia "plugin openPanel privacy-indicator";
          }
          {
            key = "n";
            desc = "Notepad";
            cmd = noctalia "plugin togglePanel notes-scratchpad";
          }
          {
            key = "t";
            desc = "To-do list";
            cmd = noctalia "plugin togglePanel todo";
          }
          {
            key = "s";
            desc = "Screen Toolkit";
            cmd = noctalia "plugin openPanel screen-toolkit";
          }
          {
            key = "c";
            desc = "Clipper";
            cmd = noctalia "plugin openPanel clipper";
          }
          {
            key = "k";
            desc = "KDEConnect";
            cmd = noctalia "plugin:kde-connect toggle";
          }
          {
            key = "m";
            desc = "MPD";
            cmd = noctalia "plugin togglePanel mpd";
          }
          {
            key = "d";
            desc = "Mirror";
            cmd = noctalia "plugin togglePanel mirror-mirror";
          }
          {
            key = "y";
            desc = "Music Search";
            cmd = noctalia "plugin togglePanel music-search";
          }
          {
            key = "t";
            desc = "Syncthing";
            cmd = noctalia "plugin togglePanel syncthing-status";
          }
        ];
      }
      {
        key = "w";
        desc = "Panels";
        submenu = [
          {
            key = "n";
            desc = "Show Network Panel";
            cmd = noctalia "network togglePanel";
          }
          {
            key = "c";
            desc = "Show Calendar";
            cmd = noctalia "calendar toggle";
          }
          {
            key = "p";
            desc = "Power panel";
            cmd = noctalia "battery togglePanel";
          }
          {
            key = "w";
            desc = "Choose Wallpaper";
            cmd = noctalia "wallpaper toggle";
          }
          {
            key = "m";
            desc = "Show System Monitor";
            cmd = noctalia "systemMonitor toggle";
          }
          {
            key = "a";
            desc = "Audio Panel";
            cmd = noctalia "volume togglePanel";
          }
          {
            key = "t";
            desc = "Show Timer";
            cmd = noctalia "plugin:timer toggle";
          }
        ];
      }
      {
        key = "n";
        desc = "Show Notifications";
        cmd = noctalia "notifications toggleHistory";
      }
      {
        key = "i";
        desc = "Toggle idle inhibition";
        cmd = noctalia "idleInhibitor toggle";
      }
      {
        key = "b";
        desc = "Toggle Noctalia bar";
        cmd = noctalia "bar toggle";
      }
      {
        key = "B";
        desc = "Toggle Noctalia dock";
        cmd = noctalia "dock toggle";
      }
      {
        key = "l";
        desc = "Toggle Nightlight";
        cmd = noctalia "nightLight toggle";
      }
      {
        key = "W";
        desc = "Random Wallpaper";
        cmd = noctalia "wallpaper random all";
      }
      {
        key = "c";
        desc = "Clipboard history";
        cmd = noctalia "launcher clipboard";
      }
      {
        key = "s";
        desc = "Noctalia Settings";
        cmd = noctalia "settings openTab about";
      }
      {
        key = "S";
        desc = "Plugin Settings";
        cmd = noctalia "settings toggleTab plugins";
      }
    ];

    "Mod+Escape" = {
      hotkey-overlay.title = "Lock";
      allow-when-locked = true;
      action = spawn "noctalia-shell" "ipc" "call" "lockScreen" "lock";
    };
    "Mod+Space" = {
      hotkey-overlay.title = "Toggle launcher";
      action = spawn "noctalia-shell" "ipc" "call" "launcher" "toggle";
    };
    "Mod+z" = {
      hotkey-overlay.title = "Dashboard";
      action = spawn "noctalia-shell" "ipc" "call" "controlCenter" "toggle";
    };
    "Ctrl+Shift+Escape" = {
      hotkey-overlay.title = "btop";
      action = spawn "kitty" "--title" "'btop'" "-e" "btop";
    };

    "Mod+A".action.spawn = mkWlrWhichKeyMenu "Audio" [
      {
        key = "P";
        desc = "Connect Airpods";
        cmd = "bluetoothctl connect 44:A7:F4:02:10:09";
      }
      {
        key = "p";
        desc = "Set Airpods";
        cmd = "pactl set-default-sink bluez_output.44_A7_F4_02_10_09.1";
      }
      {
        key = "S";
        desc = "Connect Sony XM5";
        cmd = "bluetoothctl connect AC:80:0A:43:53:C5";
      }
      {
        key = "s";
        desc = "Set Sony XM5";
        cmd = "pactl set-default-sink bluez_output.AC_80_0A_43_53_C5.1";
      }
      {
        key = "b";
        desc = "Set Behringer Interface";
        cmd = "pactl set-default-sink alsa_output.usb-BEHRINGER_UMC1820_244D6CC5-00.multichannel-output";
      }
    ];

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
      action = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.05+";
    };
    "XF86AudioLowerVolume" = {
      hotkey-overlay.hidden = true;
      allow-when-locked = true;
      action = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.05-";
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
    "XF86Tools" = {
      hotkey-overlay.title = "Lock";
      allow-when-locked = true;
      action = spawn "noctalia-shell" "ipc" "call" "lockScreen" "lock";
    };
    "Mod+XF86Tools" = {
      hotkey-overlay.title = "Session Actions";
      allow-when-locked = false;
      action = spawn "noctalia-shell" "ipc" "call" "sessionMenu" "toggle";
    };
    "XF86Favorites" = {
      hotkey-overlay.title = "Dashboard";
      allow-when-locked = false;
      action = spawn "noctalia-shell" "ipc" "call" "controlCenter" "toggle";
    };
    "XF86Display" = {
      hotkey-overlay.title = "Power off monitors";
      action = power-off-monitors;
    };

    # Debugging keys
    "Mod+Shift+D".action.spawn = mkWlrWhichKeyMenu "Debug" [
      {
        key = "p";
        desc = "Restart pipewire";
        cmd = "systemctl --user restart pipewire";
      }
      {
        key = "n";
        desc = "Kill or Start Noctalia Shell";
        cmd = "pkill .quickshell-wra* || noctalia-shell";
      }
      {
        key = "X";
        desc = "Restart Xwayland Satellite";
        cmd = "systemctl --user restart xwayland-satellite";
      }
      {
        key = "g";
        desc = "Restart xdg-desktop-portal-gnome";
        cmd = "systemctl --user restart xdg-desktop-portal-gnome.service";
      }
    ];

    "Mod+Left".action = focus-column-left;
    "Mod+Down".action = focus-window-down;
    "Mod+Up".action = focus-window-up;
    "Mod+Right".action = focus-column-right;
    "Mod+H".action = focus-column-left;
    "Mod+L".action = focus-column-right;
    # "Mod+J".action = focus-window-down;
    # "Mod+K".action = focus-window-up;

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

    "Mod+Alt+H".action = move-workspace-to-monitor-left;
    "Mod+Alt+L".action = move-workspace-to-monitor-right;
    # "Mod+Alt+K".action = move-workspace-to-monitor-up;
    # "Mod+Alt+J".action = move-workspace-to-monitor-down;

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
      cooldown-ms = 120;
      action = focus-workspace-up;
    };
    "Mod+WheelScrollDown" = {
      cooldown-ms = 120;
      action = focus-workspace-down;
    };
    "Mod+Ctrl+WheelScrollUp" = {
      cooldown-ms = 120;
      action = move-column-to-workspace-up;
    };
    "Mod+Ctrl+WheelScrollDown" = {
      cooldown-ms = 120;
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
    # "Mod+BracketLeft".action = consume-or-expel-window-left;
    # "Mod+BracketRight".action = consume-or-expel-window-right;

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
        desc = "Stretch window to all corners";
        cmd = "niri msg action maximize-window-to-edges";
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

    # "Mod+Comma".action = consume-window-into-column;
    # "Mod+Period".action = expel-window-from-column;

    "Mod+R".action = switch-preset-column-width-back;
    "Mod+Shift+R".action = switch-preset-window-height;

    "Mod+F".action = fullscreen-window;
    "Mod+Shift+F".action = expand-column-to-available-width;

    "Mod+Ctrl+Space".action = toggle-window-floating;

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
  };
}
