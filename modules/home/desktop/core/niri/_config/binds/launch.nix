{
  config,
  osConfig,
  lib,
  mkWlrWhichKeyMenu,
  ...
}: let
  hostName = osConfig.networking.hostName;
in {
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
        cmd = "kitty --title Neovim -e nvim";
      }
      {
        key = "N";
        desc = "Open Notes";
        cmd = "kitty --title Notes -e sh -c 'cd ~/notes && nix develop -c sh -c nvim'";
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
            cmd = "kitty --title btop bash -lc 'btop'";
          }
          {
            key = "k";
            desc = "kitty";
            cmd = "kitty";
          }
          {
            key = "l";
            desc = "leetcode";
            cmd = "kitty --title btop bash -lc 'nix develop ~/.nixos#default -c sh -c nvim leetcode.nvim'";
          }
          {
            key = "t";
            desc = "tmux";
            cmd = "kitty --title tmux bash -lc 'tmux a || tmux'";
          }
        ];
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
      ++ lib.optionals (hostName == "papyr")
      [
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
      ]);

    "Ctrl+Shift+Escape" = {
      hotkey-overlay.title = "btop";
      action = spawn "kitty" "--title" "'btop'" "-e" "btop";
    };
  };
}
