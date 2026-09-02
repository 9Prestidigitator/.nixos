{
  lib,
  config,
  options,
  mkWlrWhichKeyMenuWith,
  ...
}: let
  msg = cmd: "noctalia msg ${cmd}";
  spawn = cmd: "spawn:${cmd}";
in {
  config = lib.mkIf (options ? programs.noctalia.enable && config.programs.noctalia.enable) {
    programs.umbriel.settings = {
      keybinds = {
        "Mod" = spawn (msg "panel-toggle control-center");
        "Mod+Space" = spawn (msg "panel-toggle launcher");

        "Mod+Escape" = spawn (msg "session lock");
        "Mod+Alt+Delete" = spawn (msg "panel-toggle session");

        "Print" = spawn (msg "screenshot-region");
        "Ctrl+Print" = spawn (msg "screenshot-fullscreen");

        "Mod+N" = spawn (mkWlrWhichKeyMenuWith {
          name = "Noctalia";
          inhibitCompositorKeyboardShortcuts = false;
          menu = [
            {
              key = "b";
              desc = "Toggle Bluetooth";
              cmd = msg "bluetooth-toggle";
            }
            {
              key = "B";
              desc = "Toggle msg bar";
              cmd = msg "bar-toggle";
            }
            {
              key = "D";
              desc = "Toggle msg dock";
              cmd = msg "dock-toggle";
            }
            {
              key = "c";
              desc = "Clipboard history";
              cmd = msg "panel-toggle clipboard";
            }
            {
              key = "i";
              desc = "Toggle idle inhibition";
              cmd = msg "caffeine-toggle";
            }
            {
              key = "l";
              desc = "Toggle Nightlight";
              cmd = msg "nightlight-toggle";
            }
            {
              key = "n";
              desc = "Control Center";
              submenu = [
                {
                  key = "a";
                  desc = "Audio Panel";
                  cmd = msg "panel-toggle control-center audio";
                }
                {
                  key = "b";
                  desc = "Bluetooth Panel";
                  cmd = msg "panel-toggle control-center bluetooth";
                }
                {
                  key = "c";
                  desc = "Show Calendar";
                  cmd = msg "panel-toggle control-center calendar";
                }
                {
                  key = "m";
                  desc = "Show System Monitor";
                  cmd = msg "panel-toggle control-center system";
                }
                {
                  key = "n";
                  desc = "Show Network Panel";
                  cmd = msg "panel-toggle control-center network";
                }
                {
                  key = "p";
                  desc = "Show Power Panel";
                  cmd = msg "panel-toggle control-center power";
                }
                {
                  key = "s";
                  desc = "Show Screen Time";
                  cmd = msg "panel-toggle control-center screen-time";
                }
                {
                  key = "t";
                  desc = "Open tray";
                  cmd = msg "panel-toggle tray-drawer";
                }
                {
                  key = "W";
                  desc = "Show Weather Panel";
                  cmd = msg "panel-toggle control-center weather";
                }
              ];
            }
            {
              key = "o";
              desc = "Show Notifications";
              cmd = msg "panel-toggle control-center notifications";
            }
            {
              key = "O";
              desc = "Show Notifications";
              cmd = msg "notification-dnd-toggle";
            }
            {
              key = "s";
              desc = "msg Settings";
              cmd = msg "settings-toggle";
            }
            {
              key = "w";
              desc = "Choose Wallpaper";
              cmd = msg "panel-toggle wallpaper";
            }
            {
              key = "W";
              desc = "Random Wallpaper";
              cmd = msg "wallpaper-random";
            }
            {
              key = "p";
              desc = "Plugins";
              submenu = [
                {
                  key = "1";
                  desc = "Calculator Panel";
                  cmd = msg "yuuto/calculator:panel";
                }
                {
                  key = "a";
                  desc = "Audio Switcher";
                  cmd = msg "panel-toggle blackbartblues/audio-switcher:audio-switcher";
                }
                {
                  key = "A";
                  desc = "anilist";
                  cmd = msg "panel-toggle cleboost/anilist:library";
                }
                {
                  key = "d";
                  desc = "Drive health";
                  cmd = msg "panel-toggle gustav0ar/drive-health:drives";
                }
                {
                  key = "f";
                  desc = "filepicker";
                  cmd = msg "panel-toggle nightwatch75/file-search:panel";
                }
                {
                  key = "k";
                  desc = "keybinds";
                  cmd = msg "panel-toggle kenn/keybind-cheatsheet:cheatsheet";
                }
                {
                  key = "l";
                  desc = "Screen toolkit";
                  cmd = msg "panel-toggle alexander/screen-toolkit:panel";
                }
                {
                  key = "m";
                  desc = "Screen Mirror";
                  cmd = msg "panel-toggle elijaharch/wl-screen-mirror:controls";
                }
                {
                  key = "n";
                  desc = "Notes";
                  cmd = msg "panel-toggle noctalia/notes:panel";
                }
                {
                  key = "p";
                  desc = "Color Picker";
                  cmd = msg "panel-toggle oldirtty/color_picker:panel";
                }
                {
                  key = "P";
                  desc = "Port monitor";
                  cmd = msg "panel-toggle rxtsel/portctl:panel";
                }
                {
                  key = "q";
                  desc = "qr-code";
                  cmd = msg "panel-toggle yocraft/qrcode:panel";
                }
                {
                  key = "s";
                  desc = "syncthing";
                  cmd = msg "panel-toggle rylos/syncthing:panel";
                }
                {
                  key = "t";
                  desc = "Timer";
                  cmd = msg "panel-toggle noctalia/timer:panel";
                }
                {
                  key = "T";
                  desc = "Todo";
                  cmd = msg "panel-toggle nightwatch75/todo:panel";
                }
                {
                  key = "u";
                  desc = "Nix Monitor";
                  cmd = msg "panel-toggle avivbintangaringga/nix-monitor:panel";
                }
                {
                  key = "w";
                  desc = "Browse Wallhaven";
                  cmd = msg "panel-toggle noctalia/wallhaven:browser";
                }
                {
                  key = "W";
                  desc = "Wallpaper Engine";
                  cmd = msg "panel-toggle tadomika_ari/w-engine:w-engine-panel";
                }
              ];
            }
          ];
        });
      };
      events.lid_close = msg "session lock";
    };
  };
}
