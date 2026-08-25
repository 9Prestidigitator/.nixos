{
  lib,
  config,
  mkWlrWhichKeyMenu,
  ...
}: let
  noctalia = cmd: "spawn:noctalia msg ${cmd}";
in {
  config = lib.mkIf (config.desktop.shell == "noctalia") {
    programs.umbriel.settings = {
      keybinds = {
        "Mod" = noctalia "panel-toggle dashboard";
        "Mod+Space" = noctalia "panel-toggle launcher";
        "Mod+N" = noctalia mkWlrWhichKeyMenu "Noctalia" [
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
            cmd = noctalia "nightlight-toggle";
          }
          {
            key = "n";
            desc = "Control Center";
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
                key = "p";
                desc = "Show Power Panel";
                cmd = noctalia "panel-toggle control-center power";
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
            key = "O";
            desc = "Show Notifications";
            cmd = noctalia "notification-dnd-toggle";
          }
          {
            key = "s";
            desc = "Noctalia Settings";
            cmd = noctalia "settings-toggle";
          }
          {
            key = "w";
            desc = "Choose Wallpaper";
            cmd = noctalia "panel-toggle wallpaper";
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
                key = "1";
                desc = "Calculator Panel";
                cmd = noctalia "yuuto/calculator:panel";
              }
              {
                key = "a";
                desc = "Audio Switcher";
                cmd = noctalia "panel-toggle blackbartblues/audio-switcher:audio-switcher";
              }
              {
                key = "A";
                desc = "anilist";
                cmd = noctalia "panel-toggle cleboost/anilist:library";
              }
              {
                key = "d";
                desc = "Drive health";
                cmd = noctalia "panel-toggle gustav0ar/drive-health:drives";
              }
              {
                key = "f";
                desc = "filepicker";
                cmd = noctalia "panel-toggle nightwatch75/file-search:panel";
              }
              {
                key = "k";
                desc = "keybinds";
                cmd = noctalia "panel-toggle kenn/keybind-cheatsheet:cheatsheet";
              }
              {
                key = "l";
                desc = "Screen toolkit";
                cmd = noctalia "panel-toggle alexander/screen-toolkit:panel";
              }
              {
                key = "m";
                desc = "Screen Mirror";
                cmd = noctalia "panel-toggle elijaharch/wl-screen-mirror:controls";
              }
              {
                key = "n";
                desc = "Notes";
                cmd = noctalia "panel-toggle noctalia/notes:panel";
              }
              {
                key = "p";
                desc = "Color Picker";
                cmd = noctalia "panel-toggle oldirtty/color_picker:panel";
              }
              {
                key = "P";
                desc = "Port monitor";
                cmd = noctalia "panel-toggle rxtsel/portctl:panel";
              }
              {
                key = "q";
                desc = "qr-code";
                cmd = noctalia "panel-toggle yocraft/qrcode:panel";
              }
              {
                key = "s";
                desc = "syncthing";
                cmd = noctalia "panel-toggle rylos/syncthing:panel";
              }
              {
                key = "t";
                desc = "Timer";
                cmd = noctalia "panel-toggle noctalia/timer:panel";
              }
              {
                key = "T";
                desc = "Todo";
                cmd = noctalia "panel-toggle nightwatch75/todo:panel";
              }
              {
                key = "u";
                desc = "Nix Monitor";
                cmd = noctalia "panel-toggle avivbintangaringga/nix-monitor:panel";
              }
              {
                key = "w";
                desc = "Browse Wallhaven";
                cmd = noctalia "panel-toggle noctalia/wallhaven:browser";
              }
              {
                key = "W";
                desc = "Wallpaper Engine";
                cmd = noctalia "panel-toggle tadomika_ari/w-engine:w-engine-panel";
              }
            ];
          }
        ];
      };
    };
  };
}
