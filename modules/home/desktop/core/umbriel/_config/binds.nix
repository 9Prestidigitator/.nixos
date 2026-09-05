{
  mkWlrWhichKeyMenuWith,
  config,
  lib,
  osConfig,
  ...
}: let
  hostName = osConfig.networking.hostName;

  terminalCommand = title: command:
    if config.desktop.terminal.name == "ghostty"
    then "ghostty --title=${title} -e ${command}"
    else if config.desktop.terminal.name == "kitty"
    then "kitty --title ${title} -e ${command}"
    else "${config.desktop.terminal.name} -e ${command}";

  wlrMenu = name: menu:
    mkWlrWhichKeyMenuWith {
      inherit name menu;
      inhibitCompositorKeyboardShortcuts = false;
    };

  applicationsMenu = wlrMenu "Umbriel-Applications" [
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
      cmd = "nautilus -w";
    }
    {
      key = "m";
      desc = "Moonlight";
      cmd = "moonlight";
    }
    {
      key = "n";
      desc = "Neovim";
      cmd = terminalCommand "Neovim" "nvim";
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
          cmd = terminalCommand "btop" "bash -lc 'btop'";
        }
        {
          key = "k";
          desc = config.desktop.terminal.name;
          cmd = config.desktop.terminal.name;
        }
        {
          key = "l";
          desc = "leetcode";
          cmd = terminalCommand "leetcode" "bash -lc 'nvim leetcode.nvim'";
        }
        {
          key = "n";
          desc = "Open Notes";
          cmd = terminalCommand "Notes" "sh -c 'cd ~/notes && nix develop -c sh -c nvim'";
        }
        {
          key = "t";
          desc = "tmux";
          cmd = terminalCommand "tmux" "bash -lc 'tmux a || tmux'";
        }
      ];
    }
  ];

  vpnMenu = wlrMenu "Umbriel-VPN" (
    [
      {
        key = "m";
        desc = "Mullvad";
        submenu = [
          {
            key = "m";
            desc = "Open mullvad panel";
            cmd = "mullvad-vpn";
          }
          {
            key = "c";
            desc = "Connect mullvad";
            cmd = "mullvad connect";
          }
          {
            key = "d";
            desc = "Disconnect mullvad";
            cmd = "mullvad disconnect";
          }
          {
            key = "r";
            desc = "Reconnect mullvad";
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
            key = "d";
            desc = "Stop wg0";
            cmd = "pkexec systemctl stop wg-quick-wg0.service";
          }
          {
            key = "c";
            desc = "Start wg0";
            cmd = "pkexec systemctl start wg-quick-wg0.service";
          }
        ];
      }
    ]
  );
in {
  programs.umbriel = {
    settings.keybinds = {
      "Mod+Return" = "spawn:${config.desktop.terminal.name}";
      "Mod+G" = "spawn:${applicationsMenu}";
      "Mod+V" = "spawn:${vpnMenu}";

      "Mod+Left" = "window-focus-left";
      "Mod+Right" = "window-focus-right";
      "Mod+Up" = "window-focus-up";
      "Mod+Down" = "window-focus-down";

      "Mod+H" = "window-focus-left";
      "Mod+L" = "window-focus-right";
      "Mod+K" = "window-focus-or-workspace-up";
      "Mod+J" = "window-focus-or-workspace-down";

      "Mod+Q" = "window-close";
      "Mod+O" = "overview-toggle";
      "Mod+Ctrl+Space" = "window-toggle-floating";
      "Mod+F" = "window-toggle-maximize-to-edges";
      "Mod+Shift+F" = "window-toggle-fullscreen";
      "Mod+R" = "window-cycle-width";
      "Mod+Shift+R" = "window-cycle-width-back";
      "Mod+Alt+R" = "window-cycle-height";
      "Mod+Alt+Shift+R" = "window-cycle-height-back";
      "Mod+P" = "window-toggle-pinned";

      "Mod+Grave" = "workspace-focus-last";
      "Mod+Tab" = "window-focus-last";

      "Mod+T" = "window-move-to-scratchpad";
      "Mod+Shift+T" = "window-restore-from-scratchpad";
      "Mod+E" = "scratchpad-toggle";
      "Mod+Shift+E" = "scratchpad-focus-next";

      "Mod+Shift+Z" = "window-center";
      "Mod+Z" = "column-center";

      "Mod+S" = {
        action = "submap:layout";
        repeat = false;
      };

      "submap[layout],s" = {
        action = "workspace-set-layout:scrolling";
        submap = "reset";
      };
      "submap[layout],d" = {
        action = "workspace-set-layout:dwindle";
        submap = "reset";
      };
      "submap[layout],a" = {
        action = "workspace-set-layout:master";
        submap = "reset";
      };
      "submap[layout],Escape" = "submap:reset";

      "Mod+Minus" = "window-modify-width:-0.1";
      "Mod+Equal" = "window-modify-width:0.1";
      "Mod+Shift+Minus" = "window-modify-height:-0.1";
      "Mod+Shift+Equal" = "window-modify-height:0.1";

      "Mod+U" = "workspace-previous";
      "Mod+D" = "workspace-next";
      "Mod+Page_Up" = "workspace-previous";
      "Mod+Page_Down" = "workspace-next";

      "Mod+WheelUp" = "workspace-previous";
      "Mod+WheelDown" = "workspace-next";

      "Mod+1" = "workspace-switch:1";
      "Mod+2" = "workspace-switch:2";
      "Mod+3" = "workspace-switch:3";
      "Mod+4" = "workspace-switch:4";
      "Mod+5" = "workspace-switch:5";
      "Mod+6" = "workspace-switch:6";
      "Mod+7" = "workspace-switch:7";
      "Mod+8" = "workspace-switch:8";
      "Mod+9" = "workspace-switch:9";

      "Mod+Ctrl+Left" = "column-move-left";
      "Mod+Ctrl+Right" = "column-move-right";
      "Mod+Ctrl+Up" = "window-move-up";
      "Mod+Ctrl+Down" = "window-move-down";

      "Mod+Comma" = "window-consume-or-expel-left";
      "Mod+Period" = "window-consume-or-expel-right";

      "Mod+Ctrl+H" = "column-move-left";
      "Mod+Ctrl+L" = "column-move-right";
      "Mod+Ctrl+K" = "window-move-up";
      "Mod+Ctrl+J" = "window-move-down";

      "Mod+Ctrl+Page_Up" = "window-move-to-workspace-previous";
      "Mod+Ctrl+U" = "window-move-to-workspace-previous";
      "Mod+Ctrl+Page_Down" = "window-move-to-workspace-next";
      "Mod+Ctrl+D" = "window-move-to-workspace-next";

      "Mod+Ctrl+1" = "window-move-to-workspace:1";
      "Mod+Ctrl+2" = "window-move-to-workspace:2";
      "Mod+Ctrl+3" = "window-move-to-workspace:3";
      "Mod+Ctrl+4" = "window-move-to-workspace:4";
      "Mod+Ctrl+5" = "window-move-to-workspace:5";
      "Mod+Ctrl+6" = "window-move-to-workspace:6";
      "Mod+Ctrl+7" = "window-move-to-workspace:7";
      "Mod+Ctrl+8" = "window-move-to-workspace:8";
      "Mod+Ctrl+9" = "window-move-to-workspace:9";

      "Mod+Shift+H" = "output-focus-left";
      "Mod+Shift+L" = "output-focus-right";
      "Mod+Shift+K" = "output-focus-up";
      "Mod+Shift+J" = "output-focus-down";

      "Mod+Shift+Ctrl+H" = "column-move-to-output-left";
      "Mod+Shift+Ctrl+L" = "column-move-to-output-right";
      "Mod+Shift+Ctrl+K" = "column-move-to-output-up";
      "Mod+Shift+Ctrl+J" = "column-move-to-output-down";

      "Mod+Alt+H" = "workspace-move-to-output-left";
      "Mod+Alt+L" = "workspace-move-to-output-right";
      # "Mod+Alt+K" = "workspace-move-to-output-up";
      # "Mod+Alt+J" = "workspace-move-to-output-down";
      "Mod+Alt+K" = "workspace-move-up";
      "Mod+Alt+J" = "workspace-move-down";

      "Mod+MouseMiddle" = "layout-scroll-drag";

      "Mod+Slash" = "cheatsheet-toggle";
      "Ctrl+Alt+Delete" = "session-quit";
      "Mod+Shift+P" = {
        action = "dpms-off";
        allow_when_locked = true;
      };

      "XF86AudioRaiseVolume" = {
        action = "spawn:wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+";
        allow_when_locked = true;
      };
      "XF86AudioLowerVolume" = {
        action = "spawn:wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
        allow_when_locked = true;
      };
      "XF86AudioMute" = {
        action = "spawn:wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
        allow_when_locked = true;
      };

      "XF86AudioPlay" = {
        action = "spawn:playerctl play-pause";
        allow_when_locked = true;
      };
      "XF86AudioNext" = {
        action = "spawn:playerctl next";
        allow_when_locked = true;
      };
      "XF86AudioPrev" = {
        action = "spawn:playerctl prev";
        allow_when_locked = true;
      };

      "XF86MonBrightnessDown" = {
        action = "spawn:noctalia msg brightness-down 5";
        allow_when_locked = true;
      };
      "XF86MonBrightnessUp" = {
        action = "spawn:noctalia msg brightness-up 5";
        allow_when_locked = true;
      };
    };
  };
}
