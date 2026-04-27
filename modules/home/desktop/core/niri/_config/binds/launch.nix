{
  config,
  lib,
  isLaptop,
  mkWlrWhichKeyMenu,
  ...
}: {
  programs.niri.settings.binds = with config.lib.niri.actions; {
    "Mod+Space" = {
      hotkey-overlay.title = "Toggle launcher";
      action = spawn "noctalia-shell" "ipc" "call" "launcher" "toggle";
    };

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

    "Mod+V".action.spawn = mkWlrWhichKeyMenu "VPN" ([
        {
          key = "m";
          desc = "Mullvad";
          submenu = [
            {
              key = "m";
              desc = "Open mullvad panel";
              cmd = "mullvad-gui";
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
      ++ lib.optionals isLaptop
      [
        {
          key = "w";
          desc = "Stop Wireguard";
          cmd = "pkexec systemctl stop wg-quick-wg0.service";
        }
        {
          key = "W";
          desc = "Start Wireguard";
          cmd = "pkexec systemctl start wg-quick-wg0.service";
        }
      ]);

    "Ctrl+Shift+Escape" = {
      hotkey-overlay.title = "btop";
      action = spawn "kitty" "--title" "'btop'" "-e" "btop";
    };
  };
}
