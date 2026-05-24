{
  config,
  mkWlrWhichKeyMenu,
  ...
}: let
  noctalia = cmd: "noctalia msg ${cmd}";
in {
  programs.niri.settings = {
    spawn-at-startup = [{command = ["noctalia"];}];

    binds = with config.lib.niri.actions; {
      "XF86Favorites" = {
        hotkey-overlay.title = "Control Center";
        allow-when-locked = false;
        action = spawn "noctalia" "msg" "panel-toggle" "control-center";
      };
      "Mod+z" = {
        hotkey-overlay.title = "Control Center";
        allow-when-locked = false;
        action = spawn "noctalia" "msg" "panel-toggle" "control-center";
      };

      "Mod+Space" = {
        hotkey-overlay.title = "Toggle launcher";
        action = spawn "noctalia" "msg" "panel-toggle" "launcher";
      };

      "Mod+Escape" = {
        hotkey-overlay.title = "Lock";
        allow-when-locked = true;
        action = spawn "noctalia" "msg" "screen-lock";
      };

      "XF86Tools" = {
        hotkey-overlay.title = "Lock";
        allow-when-locked = true;
        action = spawn "noctalia" "msg" "screen-lock";
      };

      "Mod+XF86Tools" = {
        hotkey-overlay.title = "Session";
        allow-when-locked = false;
        action = spawn "noctalia" "msg" "panel-toggle" "session";
      };

      "Mod+N".action.spawn = mkWlrWhichKeyMenu "Noctalia" [
        {
          key = "b";
          desc = "Toggle Noctalia bar";
          cmd = noctalia "bar-toggle";
        }
        {
          key = "B";
          desc = "Toggle Noctalia dock";
          cmd = noctalia "dock-toggle";
        }
        {
          key = "c";
          desc = "Clipboard history";
          cmd = noctalia "panel-toggle clipboard";
        }
        {
          key = "i";
          desc = "Toggle idle inhibition";
          cmd = noctalia "caffeine-toggle";
        }
        {
          key = "l";
          desc = "Toggle Nightlight";
          cmd = noctalia "nightLight-toggle";
        }
        {
          key = "n";
          desc = "Panels";
          submenu = [
            {
              key = "a";
              desc = "Audio Panel";
              cmd = noctalia "volume togglePanel";
            }
            {
              key = "B";
              desc = "Bluetooth";
              cmd = noctalia "bluetooth togglePanel";
            }
            {
              key = "b";
              desc = "Toggle Bluetooth";
              cmd = noctalia "bluetooth toggle";
            }
            {
              key = "c";
              desc = "Show Calendar";
              cmd = noctalia "calendar toggle";
            }
            {
              key = "m";
              desc = "Show System Monitor";
              cmd = noctalia "systemMonitor toggle";
            }
            {
              key = "n";
              desc = "Show Network Panel";
              cmd = noctalia "network togglePanel";
            }
            {
              key = "p";
              desc = "Power panel";
              cmd = noctalia "battery togglePanel";
            }
            {
              key = "w";
              desc = "Choose Wallpaper";
              cmd = noctalia "panel-toggle wallpaper";
            }
          ];
        }
        {
          key = "o";
          desc = "Show Notifications";
          cmd = noctalia "notifications toggleHistory";
        }
        {
          key = "s";
          desc = "Noctalia Settings";
          cmd = noctalia "settings-toggle";
        }
        {
          key = "W";
          desc = "Random Wallpaper";
          cmd = noctalia "wallpaper-random";
        }
      ];
    };
  };
}
