{
  config,
  inputs,
  ...
}: {
  programs.niri.settings.binds = with config.lib.niri.actions; {
    "Mod+Shift+Slash" = {
      hotkey-overlay.title = "Show this hotkey overlay";
      action = show-hotkey-overlay;
    };

    "Mod+O" = {
      hotkey-overlay.title = "Show overview";
      action = toggle-overview;
    };

    "Mod+Return" = {
      hotkey-overlay.title = "Launch terminal: Kitty";
      action = spawn "kitty";
    };

    "Mod+B" = {
      hotkey-overlay.title = "Launch browser: Browser";
      action = spawn "brave";
    };

    "Mod+Q" = {
      hotkey-overlay.title = "Quit window";
      action = close-window;
    };

    "Mod+Escape" = {
      hotkey-overlay.title = "Lock";
      action = spawn "noctalia-shell" "ipc" "call" "lockScreen" "lock";
    };

    "Mod+Shift+I" = {
      hotkey-overlay.title = "Toggle idle inhibitor";
      action = spawn "noctalia-shell" "ipc" "call" "idleInhibitor" "toggle";
    };

    "Mod+Space" = {
      hotkey-overlay.title = "Toggle launcher";
      action = spawn "noctalia-shell" "ipc" "call" "launcher" "toggle";
    };

    "Mod+N" = {
      hotkey-overlay.title = "Show notifications";
      action = spawn "noctalia-shell" "ipc" "call" "notifications" "toggleHistory";
    };

    "Mod+Shift+B" = {
      hotkey-overlay.title = "Toggle Noctalia bar";
      action = spawn "noctalia-shell" "ipc" "call" "bar" "toggle";
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
    "Mod+Shift+D".action = move-workspace-down;
    "Mod+Shift+U".action = move-workspace-up;

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

    "Mod+Shift+F".action = expand-column-to-available-width;
    "Mod+C".action = center-column;
    "Mod+Shift+C".action = center-visible-columns;

    "Mod+V".action = toggle-window-floating;
    "Mod+Shift+V".action = switch-focus-between-floating-and-tiling;

    # Finer width adjustments.
    # This command can also:
    # * set width in pixels: "1000"
    # * adjust width in pixels: "-5" or "+5"
    # * set width as a percentage of screen width: "25%"
    # * adjust width as a percentage of screen width: "-10%" or "+10%"
    # Pixel sizes use logical, or scaled, pixels. I.e. on an output with scale 2.0,
    # (leaf "set-column-width" "100") will make the column occupy 200 physical screen pixels.
    "Mod+Minus".action.set-column-width = "-10%";
    "Mod+Equal".action.set-column-width = "+10%";

    # Finer height adjustments when in column with other windows.
    "Mod+Shift+Minus".action.set-window-height = "-10%";
    "Mod+Shift+Equal".action.set-window-height = "+10%";

    # Actions to switch layouts.
    # Note: if you uncomment these, make sure you do NOT have
    # a matching layout switch hotkey configured in xkb options above.
    # Having both at once on the same hotkey will break the switching,
    # since it will switch twice upon pressing the hotkey (once by xkb, once by niri).
    # (plain "Mod+Space"       [(leaf "switch-layout" "next")])
    # (plain "Mod+Shift+Space" [(leaf "switch-layout" "prev")])

    # Take an area screenshot. Select the area to screenshot with mouse
    "Print".action.screenshot = {show-pointer = false;};
    # Take a screenshot of the focused monitor
    "Ctrl+Print".action.screenshot-screen = {write-to-disk = true;};
    # Take a screenshot of the focused window
    "Alt+Print".action.screenshot-window = [];

    "Mod+Shift+E".action.spawn = "wlogout";

    "Mod+Shift+P".action = power-off-monitors;

    # This debug bind will tint all surfaces green, unless they are being
    # directly scanned out. It's therefore useful to check if direct scanout
    # is working.
    # (plain "Mod+Shift+Ctrl+T" [(flag "toggle-debug-tint")])
  };

  # programs.niri.config = let
  #   inherit
  #     (inputs.niri.lib.kdl)
  #     node
  #     plain
  #     leaf
  #     flag
  #     ;
  # in [
  #   (plain "binds" [
  #     # Keys consist of modifiers separated by + signs, followed by an XKB key name
  #     # in the end. To find an XKB name for a particular key, you may use a program
  #     # like wev.
  #     #
  #     # "Mod" is a special modifier equal to Super when running on a TTY, and to Alt
  #     # when running as a winit window.
  #     #
  #     # Most actions that you can bind here can also be invoked programmatically with
  #     # `niri msg action do-something`.
  #
  #     # Mod-Shift-/, which is usually the same as Mod-?,
  #     # shows a list of important hotkeys.
  #     (plain "Mod+Shift+Slash" [(flag "show-hotkey-overlay")])
  #     (plain "Mod+O" [(flag "toggle-overview")])
  #
  #     # Suggested binds for running programs: terminal, app launcher, screen locker.
  #     (plain "Mod+Return" [
  #       # (leaf "hotkey-overlay-title" "Open terminal: kitty")
  #       (leaf "spawn" ["kitty"])
  #     ])
  #
  #     (plain "Mod+B" [
  #       # (leaf "hotkey-overlay-title" "Open browser: Brave")
  #       (leaf "spawn" "brave")
  #     ])
  #
  #     (plain "Mod+Q" [
  #       # (leaf "hotkey-overlay-title" "Close window")
  #       # (leaf "repeat" false)
  #       (flag "close-window")
  #     ])
  #
  #     (plain "Mod+Escape" [
  #       # (leaf "hotkey-overlay-title" "Lockscreen")
  #       (leaf "spawn" ["noctalia-shell" "ipc" "call" "lockScreen" "lock"])
  #     ])
  #
  #     (plain "Mod+Shift+I" [
  #       (leaf "spawn" ["noctalia-shell" "ipc" "call" "idleInhibitor" "toggle"])
  #     ])
  #
  #     (plain "Mod+Space" [
  #       # (leaf "hotkey-overlay-title" "Launcher")
  #       (leaf "spawn" ["noctalia-shell" "ipc" "call" "launcher" "toggle"])
  #     ])
  #
  #     (plain "Mod+Shift+B" [
  #       # (leaf "hotkey-overlay-title" "Toggle noctalia bar")
  #       (leaf "spawn" ["noctalia-shell" "ipc" "call" "bar" "toggle"])
  #     ])
  #
  #     # You can also use a shell:
  #     # (plain "Mod+T" [(leaf "spawn" [ "bash" "-c" "notify-send hello && exec alacritty" ])])
  #
  #     # Example volume keys mappings for PipeWire & WirePlumber.
  #     (leaf "XF86AudioRaiseVolume" [
  #       (leaf "spawn" [
  #         "wpctl"
  #         "set-volume"
  #         "@DEFAULT_AUDIO_SINK@"
  #         "0.1+"
  #       ])
  #     ])
  #     (plain "XF86AudioLowerVolume" [
  #       (leaf "spawn" [
  #         "wpctl"
  #         "set-volume"
  #         "@DEFAULT_AUDIO_SINK@"
  #         "0.1-"
  #       ])
  #     ])
  #     (plain "XF86AudioMute" [
  #       (leaf "spawn" [
  #         "wpctl"
  #         "set-mute"
  #         "@DEFAULT_AUDIO_SINK@"
  #         "toggle"
  #       ])
  #     ])
  #     (plain "XF86AudioMicMute" [
  #       (leaf "spawn" [
  #         "wpctl"
  #         "set-mute"
  #         "@DEFAULT_AUDIO_SOURCE@"
  #         "toggle"
  #       ])
  #     ])
  #
  #     (plain "XF86MonBrightnessUp" [
  #       (leaf "spawn" [
  #         "brightnessctl"
  #         "--class=backlight"
  #         "set"
  #         "+10%"
  #       ])
  #     ])
  #     (plain "XF86MonBrightnessDown" [
  #       (leaf "spawn" [
  #         "brightnessctl"
  #         "--class=backlight"
  #         "set"
  #         "-10%"
  #       ])
  #     ])
  #
  #     (plain "Mod+Left" [(flag "focus-column-left")])
  #     (plain "Mod+Down" [(flag "focus-window-down")])
  #     (plain "Mod+Up" [(flag "focus-window-up")])
  #     (plain "Mod+Right" [(flag "focus-column-right")])
  #     (plain "Mod+H" [(flag "focus-column-left")])
  #     (plain "Mod+J" [(flag "focus-window-down")])
  #     (plain "Mod+K" [(flag "focus-window-up")])
  #     (plain "Mod+L" [(flag "focus-column-right")])
  #
  #     (plain "Mod+Ctrl+Left" [(flag "move-column-left")])
  #     (plain "Mod+Ctrl+Down" [(flag "move-window-down")])
  #     (plain "Mod+Ctrl+Up" [(flag "move-window-up")])
  #     (plain "Mod+Ctrl+Right" [(flag "move-column-right")])
  #     (plain "Mod+Ctrl+H" [(flag "move-column-left")])
  #     (plain "Mod+Ctrl+J" [(flag "move-window-down")])
  #     (plain "Mod+Ctrl+K" [(flag "move-window-up")])
  #     (plain "Mod+Ctrl+L" [(flag "move-column-right")]) # 27
  #
  #     # Alternative commands that move across workspaces when reaching
  #     # the first or last window in a column.
  #     # (plain "Mod+J"      [(flag "focus-window-or-workspace-down")])
  #     # (plain "Mod+K"      [(flag "focus-window-or-workspace-up")])
  #     # (plain "Mod+Ctrl+J" [(flag "move-window-down-or-to-workspace-down")])
  #     # (plain "Mod+Ctrl+K" [(flag "move-window-up-or-to-workspace-up")])
  #
  #     (plain "Mod+Home" [(flag "focus-column-first")])
  #     (plain "Mod+End" [(flag "focus-column-last")])
  #     (plain "Mod+Ctrl+Home" [(flag "move-column-to-first")])
  #     (plain "Mod+Ctrl+End" [(flag "move-column-to-last")])
  #
  #     (plain "Mod+Shift+Left" [(flag "focus-monitor-left")])
  #     (plain "Mod+Shift+Down" [(flag "focus-monitor-down")])
  #     (plain "Mod+Shift+Up" [(flag "focus-monitor-up")])
  #     (plain "Mod+Shift+Right" [(flag "focus-monitor-right")])
  #     (plain "Mod+Shift+H" [(flag "focus-monitor-left")])
  #     (plain "Mod+Shift+J" [(flag "focus-monitor-down")])
  #     (plain "Mod+Shift+K" [(flag "focus-monitor-up")])
  #     (plain "Mod+Shift+L" [(flag "focus-monitor-right")])
  #
  #     (plain "Mod+Shift+Ctrl+Left" [(flag "move-column-to-monitor-left")])
  #     (plain "Mod+Shift+Ctrl+Down" [(flag "move-column-to-monitor-down")])
  #     (plain "Mod+Shift+Ctrl+Up" [(flag "move-column-to-monitor-up")])
  #     (plain "Mod+Shift+Ctrl+Right" [(flag "move-column-to-monitor-right")])
  #     (plain "Mod+Shift+Ctrl+H" [(flag "move-column-to-monitor-left")])
  #     (plain "Mod+Shift+Ctrl+J" [(flag "move-column-to-monitor-down")])
  #     (plain "Mod+Shift+Ctrl+K" [(flag "move-column-to-monitor-up")])
  #     (plain "Mod+Shift+Ctrl+L" [(flag "move-column-to-monitor-right")]) # 47
  #
  #     # Alternatively, there are commands to move just a single window:
  #     # (plain "Mod+Shift+Ctrl+Left" [(flag "move-window-to-monitor-left")])
  #     # ...
  #
  #     # And you can also move a whole workspace to another monitor:
  #     # (plain "Mod+Shift+Ctrl+Left" [(flag "move-workspace-to-monitor-left")])
  #     # ...
  #
  #     (plain "Mod+Page_Down" [(flag "focus-workspace-down")])
  #     (plain "Mod+Page_Up" [(flag "focus-workspace-up")])
  #     (plain "Mod+D" [(flag "focus-workspace-down")])
  #     (plain "Mod+U" [(flag "focus-workspace-up")])
  #     (plain "Mod+Ctrl+Page_Down" [(flag "move-column-to-workspace-down")])
  #     (plain "Mod+Ctrl+Page_Up" [(flag "move-column-to-workspace-up")])
  #     (plain "Mod+Ctrl+D" [(flag "move-column-to-workspace-down")])
  #     (plain "Mod+Ctrl+U" [(flag "move-column-to-workspace-up")])
  #
  #     # Alternatively, there are commands to move just a single window:
  #     # (plain "Mod+Ctrl+Page_Down" [(flag "move-window-to-workspace-down")])
  #     # ...
  #
  #     (plain "Mod+Shift+Page_Down" [(flag "move-workspace-down")])
  #     (plain "Mod+Shift+Page_Up" [(flag "move-workspace-up")])
  #     (plain "Mod+Shift+D" [(flag "move-workspace-down")])
  #     (plain "Mod+Shift+U" [(flag "move-workspace-up")])
  #
  #     (plain "Mod+WheelScrollUp" [(flag "focus-workspace-up")]) # 60
  #     (plain "Mod+WheelScrollDown" [(flag "focus-workspace-down")])
  #     (plain "Mod+Ctrl+WheelScrollUp" [(flag "move-column-to-workspace-up")])
  #     (plain "Mod+Ctrl+WheelScrollDown" [(flag "move-column-to-workspace-down")])
  #
  #     (plain "Mod+WheelScrollRight" [(flag "focus-column-right")])
  #     (plain "Mod+WheelScrollLeft" [(flag "focus-column-left")])
  #     (plain "Mod+Ctrl+WheelScrollRight" [(flag "move-column-right")])
  #     (plain "Mod+Ctrl+WheelScrollLeft" [(flag "move-column-left")])
  #
  #     # You can refer to workspaces by index. However, keep in mind that
  #     # niri is a dynamic workspace system, so these commands are kind of
  #     # "best effort". Trying to refer to a workspace index bigger than
  #     # the current workspace count will instead refer to the bottommost
  #     # (empty) workspace.
  #     #
  #     # For example, with 2 workspaces + 1 empty, indices 3, 4, 5 and so on
  #     # will all refer to the 3rd workspace.
  #     (plain "Mod+1" [(leaf "focus-workspace" 1)])
  #     (plain "Mod+2" [(leaf "focus-workspace" 2)])
  #     (plain "Mod+3" [(leaf "focus-workspace" 3)])
  #     (plain "Mod+4" [(leaf "focus-workspace" 4)])
  #     (plain "Mod+5" [(leaf "focus-workspace" 5)])
  #     (plain "Mod+6" [(leaf "focus-workspace" 6)])
  #     (plain "Mod+7" [(leaf "focus-workspace" 7)])
  #     (plain "Mod+8" [(leaf "focus-workspace" 8)])
  #     (plain "Mod+9" [(leaf "focus-workspace" 9)])
  #     (plain "Mod+Ctrl+1" [(leaf "move-column-to-workspace" 1)])
  #     (plain "Mod+Ctrl+2" [(leaf "move-column-to-workspace" 2)])
  #     (plain "Mod+Ctrl+3" [(leaf "move-column-to-workspace" 3)])
  #     (plain "Mod+Ctrl+4" [(leaf "move-column-to-workspace" 4)])
  #     (plain "Mod+Ctrl+5" [(leaf "move-column-to-workspace" 5)])
  #     (plain "Mod+Ctrl+6" [(leaf "move-column-to-workspace" 6)])
  #     (plain "Mod+Ctrl+7" [(leaf "move-column-to-workspace" 7)])
  #     (plain "Mod+Ctrl+8" [(leaf "move-column-to-workspace" 8)])
  #     (plain "Mod+Ctrl+9" [(leaf "move-column-to-workspace" 9)]) # 85
  #
  #     (plain "Mod+Tab" [(flag "focus-workspace-previous")])
  #
  #     # Alternatively, there are commands to move just a single window:
  #     # (plain "Mod+Ctrl+1" [(leaf "move-window-to-workspace" 1)])
  #
  #     # There are also commands that consume or expel a single window to the side.
  #     (plain "Mod+BracketLeft" [(flag "consume-or-expel-window-left")])
  #     (plain "Mod+BracketRight" [(flag "consume-or-expel-window-right")])
  #
  #     (plain "Mod+Comma" [(flag "consume-window-into-column")])
  #     (plain "Mod+Period" [(flag "expel-window-from-column")])
  #
  #     (plain "Mod+R" [(flag "switch-preset-column-width-back")])
  #     (plain "Mod+Shift+R" [(flag "switch-preset-window-height")])
  #     (plain "Mod+Ctrl+R" [(flag "reset-window-height")])
  #     (plain "Mod+M" [(flag "maximize-column")])
  #     (plain "Mod+F" [(flag "fullscreen-window")])
  #
  #     (plain "Mod+Shift+F" [(flag "expand-column-to-available-width")])
  #     (plain "Mod+C" [(flag "center-column")])
  #     (plain "Mod+Shift+C" [(flag "center-visible-columns")])
  #
  #     (plain "Mod+V" [(flag "toggle-window-floating")])
  #     (plain "Mod+Shift+V" [(flag "switch-focus-between-floating-and-tiling")])
  #
  #     # Finer width adjustments.
  #     # This command can also:
  #     # * set width in pixels: "1000"
  #     # * adjust width in pixels: "-5" or "+5"
  #     # * set width as a percentage of screen width: "25%"
  #     # * adjust width as a percentage of screen width: "-10%" or "+10%"
  #     # Pixel sizes use logical, or scaled, pixels. I.e. on an output with scale 2.0,
  #     # (leaf "set-column-width" "100") will make the column occupy 200 physical screen pixels.
  #     (plain "Mod+Minus" [(leaf "set-column-width" "-10%")])
  #     (plain "Mod+Equal" [(leaf "set-column-width" "+10%")])
  #
  #     # Finer height adjustments when in column with other windows.
  #     (plain "Mod+Shift+Minus" [(leaf "set-window-height" "-10%")])
  #     (plain "Mod+Shift+Equal" [(leaf "set-window-height" "+10%")])
  #
  #     # Actions to switch layouts.
  #     # Note: if you uncomment these, make sure you do NOT have
  #     # a matching layout switch hotkey configured in xkb options above.
  #     # Having both at once on the same hotkey will break the switching,
  #     # since it will switch twice upon pressing the hotkey (once by xkb, once by niri).
  #     # (plain "Mod+Space"       [(leaf "switch-layout" "next")])
  #     # (plain "Mod+Shift+Space" [(leaf "switch-layout" "prev")])
  #
  #     # Take an area screenshot. Select the area to screenshot with mouse
  #     (plain "Print" [(flag "screenshot")])
  #     # Take a screenshot of the focused monitor
  #     (plain "Ctrl+Print" [(flag "screenshot-screen")])
  #     # Take a screenshot of the focused window
  #     (plain "Alt+Print" [(flag "screenshot-window")])
  #
  #     (plain "Mod+Shift+E" [(leaf "spawn" ["wlogout"])])
  #
  #     (plain "Mod+Shift+P" [(flag "power-off-monitors")])
  #
  #     # This debug bind will tint all surfaces green, unless they are being
  #     # directly scanned out. It's therefore useful to check if direct scanout
  #     # is working.
  #     # (plain "Mod+Shift+Ctrl+T" [(flag "toggle-debug-tint")])
  #   ])
  # ];
}
