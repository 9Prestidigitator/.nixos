{
  config,
  mkWlrWhichKeyMenu,
  ...
}: let
  noctalia = cmd: "noctalia-shell ipc call ${cmd}";
in {
  programs.niri.settings.binds = with config.lib.niri.actions; {
    "XF86Favorites" = {
      hotkey-overlay.title = "Dashboard";
      allow-when-locked = false;
      action = spawn "noctalia-shell" "ipc" "call" "controlCenter" "toggle";
    };
    "Mod+z" = {
      hotkey-overlay.title = "Dashboard";
      action = spawn "noctalia-shell" "ipc" "call" "controlCenter" "toggle";
    };

    "Mod+Escape" = {
      hotkey-overlay.title = "Lock";
      allow-when-locked = true;
      action = spawn "noctalia-shell" "ipc" "call" "lockScreen" "lock";
    };

    "Mod+N".action.spawn = mkWlrWhichKeyMenu "Noctalia" [
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
        key = "c";
        desc = "Clipboard history";
        cmd = noctalia "launcher clipboard";
      }
      {
        key = "i";
        desc = "Toggle idle inhibition";
        cmd = noctalia "idleInhibitor toggle";
      }
      {
        key = "l";
        desc = "Toggle Nightlight";
        cmd = noctalia "nightLight toggle";
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
            key = "t";
            desc = "Show Timer";
            cmd = noctalia "plugin:timer toggle";
          }
          {
            key = "w";
            desc = "Choose Wallpaper";
            cmd = noctalia "wallpaper toggle";
          }
        ];
      }
      {
        key = "o";
        desc = "Show Notifications";
        cmd = noctalia "notifications toggleHistory";
      }
      {
        key = "p";
        desc = "Plugins";
        submenu = [
          {
            key = "1";
            desc = "Calculator";
            cmd = noctalia "plugin togglePanel noctalia-calculator";
          }
          {
            key = "a";
            desc = "Assistant Panel";
            cmd = noctalia "plugin openPanel assistant-panel";
          }
          {
            key = "c";
            desc = "Clipper";
            cmd = noctalia "plugin openPanel clipper";
          }
          {
            key = "d";
            desc = "Mirror";
            cmd = noctalia "plugin togglePanel mirror-mirror";
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
            key = "n";
            desc = "Notepad";
            cmd = noctalia "plugin togglePanel notes-scratchpad";
          }
          {
            key = "p";
            desc = "Privacy";
            cmd = noctalia "plugin openPanel privacy-indicator";
          }
          {
            key = "P";
            desc = "Port Monitor";
            cmd = noctalia "plugin togglePanel port-monitor";
          }
          {
            key = "r";
            desc = "Syncthing";
            cmd = noctalia "plugin togglePanel syncthing-status";
          }
          {
            key = "s";
            desc = "Screen Toolkit";
            cmd = noctalia "plugin openPanel screen-toolkit";
          }
          {
            key = "t";
            desc = "To-do list";
            cmd = noctalia "plugin togglePanel todo";
          }
          {
            key = "u";
            desc = "USB Drive Manager";
            cmd = noctalia "plugin togglePanel usb-drive-manager";
          }
          {
            key = "w";
            desc = "Wallpaper Engine";
            cmd = noctalia "plugin togglePanel linux-wallpaperengine-controller";
          }
          {
            key = "y";
            desc = "Music Search";
            cmd = noctalia "plugin togglePanel music-search";
          }
        ];
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
      {
        key = "W";
        desc = "Random Wallpaper";
        cmd = noctalia "wallpaper random all";
      }
    ];
  };
}
