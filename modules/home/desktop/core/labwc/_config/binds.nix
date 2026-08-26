{
  config,
  lib,
  osConfig,
  pkgs,
  mkWlrWhichKeyMenuWith,
  ...
}: let
  hostName = osConfig.networking.hostName;

  mkAction = name: attrs:
    {"@name" = name;}
    // lib.mapAttrs' (attr: value: lib.nameValuePair "@${attr}" value) attrs;
  execute = command: mkAction "Execute" {inherit command;};
  showMenu = menu: mkAction "ShowMenu" {inherit menu;};
  goToDesktop = to: mkAction "GoToDesktop" {inherit to;};
  sendToDesktop = to:
    mkAction "SendToDesktop" {
      inherit to;
      follow = "yes";
    };

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

  applicationsMenu = wlrMenu "Applications" [
    {
      key = "a";
      desc = "Audio";
      submenu = [
        {
          key = "b";
          desc = "Bitwig";
          cmd = "bitwig-studio";
        }
        {
          key = "j";
          desc = "QJackCtl";
          cmd = "qjackctl";
        }
        {
          key = "q";
          desc = "qpwgraph";
          cmd = "qpwgraph";
        }
        {
          key = "r";
          desc = "Reaper";
          cmd = "reaper";
        }
        {
          key = "s";
          desc = "Spotify";
          cmd = "spotify";
        }
      ];
    }
    {
      key = "b";
      desc = "Brave";
      cmd = "brave";
    }
    {
      key = "c";
      desc = "Communications";
      submenu = [
        {
          key = "d";
          desc = "Discord";
          cmd = "discord";
        }
        {
          key = "s";
          desc = "Signal";
          cmd = "signal-desktop";
        }
      ];
    }
    {
      key = "e";
      desc = "Files";
      cmd = "${config.desktop.explorer.name} -w";
    }
    {
      key = "m";
      desc = "Moonlight";
      cmd = "moonlight";
    }
    {
      key = "n";
      desc = "Neovim";
      cmd = "kitty --title Neovim -e nvim";
    }
    {
      key = "o";
      desc = "Obsidian";
      cmd = "obsidian";
    }
    {
      key = "s";
      desc = "Steam";
      cmd = "steam";
    }
    {
      key = "t";
      desc = "Terminal";
      submenu = [
        {
          key = "b";
          desc = "btop";
          cmd = "kitty --title btop -e btop";
        }
        {
          key = "e";
          desc = "${config.desktop.terminal.name}";
          cmd = "${config.desktop.terminal.name}";
        }
        {
          key = "n";
          desc = "Notes";
          cmd = "kitty --title Notes -e sh -c 'cd ~/notes && nix develop -c nvim'";
        }
        {
          key = "t";
          desc = "tmux";
          cmd = "kitty --title tmux -e sh -c 'tmux a || tmux'";
        }
      ];
    }
  ];

  vpnMenu = wlrMenu "VPN" (
    [
      {
        key = "m";
        desc = "Mullvad";
        submenu = [
          {
            key = "m";
            desc = "Open Mullvad";
            cmd = "mullvad-vpn";
          }
          {
            key = "c";
            desc = "Connect";
            cmd = "mullvad connect";
          }
          {
            key = "d";
            desc = "Disconnect";
            cmd = "mullvad disconnect";
          }
          {
            key = "r";
            desc = "Reconnect";
            cmd = "mullvad reconnect";
          }
        ];
      }
    ]
    ++ lib.optionals (hostName == "papyr") [
      {
        key = "w";
        desc = "wg0";
        submenu = [
          {
            key = "c";
            desc = "Start wg0";
            cmd = "pkexec systemctl start wg-quick-wg0.service";
          }
          {
            key = "d";
            desc = "Stop wg0";
            cmd = "pkexec systemctl stop wg-quick-wg0.service";
          }
        ];
      }
    ]
  );

  audioMenu = wlrMenu "Audio" [
    {
      key = "b";
      desc = "Behringer interface";
      cmd = "pactl set-default-sink alsa_output.usb-BEHRINGER_UMC1820_244D6CC5-00.multichannel-output";
    }
    {
      key = "p";
      desc = "AirPods";
      cmd = "pactl set-default-sink bluez_output.44_A7_F4_02_10_09.1";
    }
    {
      key = "P";
      desc = "Connect AirPods";
      cmd = "bluetoothctl connect 44:A7:F4:02:10:09";
    }
    {
      key = "s";
      desc = "Sony XM5";
      cmd = "pactl set-default-sink bluez_output.AC_80_0A_43_53_C5.1";
    }
    {
      key = "S";
      desc = "Connect Sony XM5";
      cmd = "bluetoothctl connect AC:80:0A:43:53:C5";
    }
  ];

  debugMenu = wlrMenu "Debug" [
    {
      key = "p";
      desc = "Restart PipeWire";
      cmd = "systemctl --user restart pipewire.service";
    }
    {
      key = "n";
      desc = "Restart Noctalia";
      cmd = "systemctl --user restart noctalia.service";
    }
    {
      key = "x";
      desc = "Restart Xwayland satellite";
      cmd = "systemctl --user restart xwayland-satellite.service";
    }
    {
      key = "d";
      desc = "Restart desktop portals";
      cmd = "systemctl --user restart xdg-desktop-portal.service";
    }
  ];

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

  workspaceKeybinds = lib.concatMap (workspace: let
    number = toString workspace;
  in [
    (mkKeybind "W-${number}" (goToDesktop number))
    (mkKeybind "W-C-${number}" (sendToDesktop number))
  ]) (lib.range 1 9);

  genericKeybinds = [
    (mkKeybind "W-Return" (execute "${config.desktop.terminal.name}"))
    (mkKeybind "C-S-Escape" (execute "kitty --title btop -e btop"))

    (mkKeybind "W-Left" (mkAction "PreviousWindowImmediate" {}))
    (mkKeybind "W-h" (mkAction "PreviousWindowImmediate" {}))
    (mkKeybind "W-Right" (mkAction "NextWindowImmediate" {}))
    (mkKeybind "W-l" (mkAction "NextWindowImmediate" {}))
    (mkKeybind "W-Up" (goToDesktop "left"))
    (mkKeybind "W-k" (goToDesktop "left"))
    (mkKeybind "W-Down" (goToDesktop "right"))
    (mkKeybind "W-j" (goToDesktop "right"))
    (mkKeybind "W-Tab" (goToDesktop "last"))

    (mkKeybind "W-S-Left" (mkAction "FocusOutput" {direction = "left";}))
    (mkKeybind "W-S-h" (mkAction "FocusOutput" {direction = "left";}))
    (mkKeybind "W-S-Right" (mkAction "FocusOutput" {direction = "right";}))
    (mkKeybind "W-S-l" (mkAction "FocusOutput" {direction = "right";}))
    (mkKeybind "W-S-Up" (mkAction "FocusOutput" {direction = "up";}))
    (mkKeybind "W-S-k" (mkAction "FocusOutput" {direction = "up";}))
    (mkKeybind "W-S-Down" (mkAction "FocusOutput" {direction = "down";}))
    (mkKeybind "W-S-j" (mkAction "FocusOutput" {direction = "down";}))

    (mkKeybind "W-C-S-Left" (mkAction "MoveToOutput" {direction = "left";}))
    (mkKeybind "W-C-S-h" (mkAction "MoveToOutput" {direction = "left";}))
    (mkKeybind "W-C-S-Right" (mkAction "MoveToOutput" {direction = "right";}))
    (mkKeybind "W-C-S-l" (mkAction "MoveToOutput" {direction = "right";}))
    (mkKeybind "W-C-S-Up" (mkAction "MoveToOutput" {direction = "up";}))
    (mkKeybind "W-C-S-k" (mkAction "MoveToOutput" {direction = "up";}))
    (mkKeybind "W-C-S-Down" (mkAction "MoveToOutput" {direction = "down";}))
    (mkKeybind "W-C-S-j" (mkAction "MoveToOutput" {direction = "down";}))

    (mkKeybind "W-C-h" (mkAction "MoveToEdge" {direction = "left";}))
    (mkKeybind "W-C-l" (mkAction "MoveToEdge" {direction = "right";}))
    (mkKeybind "W-C-k" (sendToDesktop "left"))
    (mkKeybind "W-C-j" (sendToDesktop "right"))
    (mkKeybind "W-C-Page_Up" (sendToDesktop "left"))
    (mkKeybind "W-C-Page_Down" (sendToDesktop "right"))

    (mkKeybind "W-C-Left" (mkAction "ToggleSnapToEdge" {direction = "left";}))
    (mkKeybind "W-C-Right" (mkAction "ToggleSnapToEdge" {direction = "right";}))
    (mkKeybind "W-C-Up" (mkAction "ToggleMaximize" {direction = "vertical";}))
    (mkKeybind "W-C-Down" (mkAction "UnSnap" {}))

    (mkKeybind "W-q" (mkAction "Close" {}))
    (mkKeybind "W-o" (showMenu "client-list-combined-menu"))
    (mkKeybind "W-w" (showMenu "client-menu"))
    (mkKeybind "W-r" (mkAction "ToggleMaximize" {}))
    (mkKeybind "W-f" (mkAction "ToggleMaximize" {}))
    (mkKeybind "W-S-f" (mkAction "ToggleFullscreen" {}))
    (mkKeybind "W-C-space" (mkAction "UnSnap" {}))

    (mkKeybind "W-minus" (mkAction "ResizeRelative" {
      left = "-50";
      right = "-50";
    }))
    (mkKeybind "W-equal" (mkAction "ResizeRelative" {
      left = "50";
      right = "50";
    }))
    (mkKeybind "W-S-minus" (mkAction "ResizeRelative" {
      top = "-50";
      bottom = "-50";
    }))
    (mkKeybind "W-S-equal" (mkAction "ResizeRelative" {
      top = "50";
      bottom = "50";
    }))

    (mkKeybind "W-A-1" (mkAction "ToggleSnapToRegion" {region = "left-third";}))
    (mkKeybind "W-A-2" (mkAction "ToggleSnapToRegion" {region = "center-third";}))
    (mkKeybind "W-A-3" (mkAction "ToggleSnapToRegion" {region = "right-third";}))
    (mkKeybind "W-A-5" (mkAction "ToggleSnapToRegion" {region = "center-half";}))

    (mkKeybind "W-g" (execute applicationsMenu))
    (mkKeybind "W-v" (execute vpnMenu))
    (mkKeybind "W-a" (execute audioMenu))
    (mkKeybind "W-S-d" (execute debugMenu))

    (mkKeybindWith "XF86AudioPlay" {
      allowWhenLocked = "yes";
      overrideInhibition = "yes";
    } (execute "${lib.getExe pkgs.playerctl} play-pause"))
    (mkKeybindWith "XF86AudioPause" {
      allowWhenLocked = "yes";
      overrideInhibition = "yes";
    } (execute "${lib.getExe pkgs.playerctl} play-pause"))
    (mkKeybindWith "XF86AudioNext" {
      allowWhenLocked = "yes";
      overrideInhibition = "yes";
    } (execute "${lib.getExe pkgs.playerctl} next"))
    (mkKeybindWith "XF86AudioPrev" {
      allowWhenLocked = "yes";
      overrideInhibition = "yes";
    } (execute "${lib.getExe pkgs.playerctl} previous"))
    (mkKeybindWith "XF86AudioRaiseVolume" {
      allowWhenLocked = "yes";
      overrideInhibition = "yes";
    } (execute "${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05+"))
    (mkKeybindWith "XF86AudioLowerVolume" {
      allowWhenLocked = "yes";
      overrideInhibition = "yes";
    } (execute "${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05-"))
    (mkKeybindWith "XF86AudioMute" {
      allowWhenLocked = "yes";
      overrideInhibition = "yes";
    } (execute "${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"))
    (mkKeybindWith "XF86AudioMicMute" {
      allowWhenLocked = "yes";
      overrideInhibition = "yes";
    } (execute "${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"))
    (mkKeybindWith "XF86MonBrightnessUp" {
      allowWhenLocked = "yes";
      overrideInhibition = "yes";
    } (execute "${lib.getExe pkgs.brightnessctl} --class=backlight set +5%"))
    (mkKeybindWith "XF86MonBrightnessDown" {
      allowWhenLocked = "yes";
      overrideInhibition = "yes";
    } (execute "${lib.getExe pkgs.brightnessctl} --class=backlight set 5%-"))
    (mkKeybind "XF86Display" (execute "${lib.getExe pkgs.wlopm} --off '*'"))
    (mkKeybind "W-S-p" (execute "${lib.getExe pkgs.wlopm} --off '*'"))

    (mkKeybind "C-A-Delete" {
      "@name" = "If";
      prompt."@message" = "Exit Labwc?";
      "then".action = mkAction "Exit" {};
    })
  ];

  noctaliaKeybinds = lib.optionals (config.desktop.shell == "noctalia") [
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
in {
  wayland.windowManager.labwc.rc = {
    keyboard = {
      default = true;
      keybind = genericKeybinds ++ workspaceKeybinds ++ noctaliaKeybinds;
    };

    mouse = {
      default = true;
      context = [
        {
          "@name" = "Root";
          mousebind = {
            "@button" = "Right";
            "@action" = "Press";
            action = showMenu "root-menu";
          };
        }
        {
          "@name" = "All";
          mousebind = [
            {
              "@direction" = "W-Up";
              "@action" = "Scroll";
              action = goToDesktop "left";
            }
            {
              "@direction" = "W-Down";
              "@action" = "Scroll";
              action = goToDesktop "right";
            }
            {
              "@direction" = "W-Left";
              "@action" = "Scroll";
              action = mkAction "PreviousWindowImmediate" {};
            }
            {
              "@direction" = "W-Right";
              "@action" = "Scroll";
              action = mkAction "NextWindowImmediate" {};
            }
          ];
        }
      ];
    };
  };
}
