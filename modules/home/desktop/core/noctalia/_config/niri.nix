{
  config,
  mkWlrWhichKeyMenu,
  ...
}: let
  noctalia = cmd: "noctalia msg ${cmd}";
in {
  programs.niri.settings = {
    switch-events.lid-close.action.spawn = ["noctalia" "msg" "session" "lock"];

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
        action = spawn "noctalia" "msg" "session" "lock";
      };

      "XF86Tools" = {
        hotkey-overlay.title = "Lock";
        allow-when-locked = true;
        action = spawn "noctalia" "msg" "session" "lock";
      };

      "Mod+XF86Tools" = {
        hotkey-overlay.title = "Session";
        allow-when-locked = false;
        action = spawn "noctalia" "msg" "panel-toggle" "session";
      };

      "Mod+Alt+Delete" = {
        hotkey-overlay.title = "Session";
        allow-when-locked = false;
        action = spawn "noctalia" "msg" "panel-toggle" "session";
      };

      "Mod+N".action.spawn = mkWlrWhichKeyMenu "Noctalia" [
        {
          key = "b";
          desc = "Toggle Bluetooth";
          cmd = noctalia "bluetooth-toggle";
        }
        {
          key = "B";
          desc = "Toggle Noctalia bar";
          cmd = noctalia "bar-toggle";
        }
        {
          key = "D";
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
              cmd = noctalia "panel-toggle control-center audio";
            }
            {
              key = "b";
              desc = "Bluetooth Panel";
              cmd = noctalia "panel-toggle control-center bluetooth";
            }
            {
              key = "c";
              desc = "Show Calendar";
              cmd = noctalia "panel-toggle control-center calendar";
            }
            {
              key = "m";
              desc = "Show System Monitor";
              cmd = noctalia "panel-toggle control-center system";
            }
            {
              key = "n";
              desc = "Show Network Panel";
              cmd = noctalia "panel-toggle control-center network";
            }
            {
              key = "s";
              desc = "Show Screen Time";
              cmd = noctalia "panel-toggle control-center screen-time";
            }
            {
              key = "t";
              desc = "Open tray";
              cmd = noctalia "panel-toggle tray-drawer";
            }
            {
              key = "w";
              desc = "Choose Wallpaper";
              cmd = noctalia "panel-toggle wallpaper";
            }
            {
              key = "W";
              desc = "Show Weather Panel";
              cmd = noctalia "panel-toggle control-center weather";
            }
          ];
        }
        {
          key = "o";
          desc = "Show Notifications";
          cmd = noctalia "panel-toggle control-center notifications";
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
        {
          key = "p";
          desc = "Plugins";
          submenu = [
            {
              key = "w";
              desc = "Browse Wallhaven";
              cmd = noctalia "panel-toggle noctalia/wallhaven:browser";
            }
          ];
        }
      ];
    };
  };
}
