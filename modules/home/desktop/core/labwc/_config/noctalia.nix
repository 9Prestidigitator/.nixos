{
  config,
  lib,
  options,
  mkWlrWhichKeyMenuWith,
  ...
}: let
  mkAction = name: attrs:
    {"@name" = name;}
    // lib.mapAttrs' (attr: value: lib.nameValuePair "@${attr}" value) attrs;
  execute = command: mkAction "Execute" {inherit command;};

  mkKeybind = key: action: {
    "@key" = key;
    inherit action;
  };
  mkKeybindWith = key: attrs: action:
    {
      "@key" = key;
      inherit action;
    }
    // lib.mapAttrs' (attr: value: lib.nameValuePair "@${attr}" value) attrs;

  wlrMenu = name: menu:
    mkWlrWhichKeyMenuWith {
      name = "Labwc-${name}";
      inhibitCompositorKeyboardShortcuts = false;
      inherit menu;
    };

  noctalia = command: "noctalia msg ${command}";
  noctaliaMenu = wlrMenu "Noctalia" [
    {
      key = "b";
      desc = "Toggle Bluetooth";
      cmd = noctalia "bluetooth-toggle";
    }
    {
      key = "B";
      desc = "Toggle bar";
      cmd = noctalia "bar-toggle";
    }
    {
      key = "D";
      desc = "Toggle dock";
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
      desc = "Toggle night light";
      cmd = noctalia "nightlight-toggle";
    }
    {
      key = "n";
      desc = "Control center";
      cmd = noctalia "panel-toggle control-center";
    }
    {
      key = "o";
      desc = "Notifications";
      cmd = noctalia "panel-toggle control-center notifications";
    }
    {
      key = "O";
      desc = "Do not disturb";
      cmd = noctalia "notification-dnd-toggle";
    }
    {
      key = "s";
      desc = "Settings";
      cmd = noctalia "settings-toggle";
    }
    {
      key = "w";
      desc = "Choose wallpaper";
      cmd = noctalia "panel-toggle wallpaper";
    }
    {
      key = "W";
      desc = "Random wallpaper";
      cmd = noctalia "wallpaper-random";
    }
  ];
in {
  wayland.windowManager.labwc.rc = {
    keyboard = {
      default = true;
      keybind = lib.optionals (options ? programs.noctalia.enable && config.programs.noctalia.enable) [
        (mkKeybindWith "Super_L" {
          onRelease = "yes";
        } (execute (noctalia "panel-toggle control-center")))
        (mkKeybind "W-space" (execute (noctalia "panel-toggle launcher")))
        (mkKeybindWith "W-Escape" {allowWhenLocked = "yes";} (execute (noctalia "session lock")))
        (mkKeybindWith "XF86Tools" {allowWhenLocked = "yes";} (execute (noctalia "session lock")))
        (mkKeybind "W-XF86Tools" (execute (noctalia "panel-toggle session")))
        (mkKeybind "W-A-Delete" (execute (noctalia "panel-toggle session")))
        (mkKeybind "W-n" (execute noctaliaMenu))
        (mkKeybind "Print" (execute (noctalia "screenshot-region")))
        (mkKeybind "C-Print" (execute (noctalia "screenshot-fullscreen")))
      ];
    };
  };
}
