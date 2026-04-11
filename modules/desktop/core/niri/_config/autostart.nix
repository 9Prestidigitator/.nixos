{
  config,
  lib,
  osConfig,
  ...
}: let
  hostName = osConfig.networking.hostName;
in {
  programs.niri.settings = lib.mkMerge [
    {
      spawn-at-startup = [
        {command = ["noctalia-shell"];}
      ];
    }
    (lib.mkIf (hostName == "ink") {
      spawn-at-startup = [
        {argv = ["sunshine"];}
        {argv = ["brave"];}
        {argv = ["spotify"];}
        {argv = ["steam"];}
        {argv = ["signal-desktop"];}
        {argv = ["obsidian"];}
        {
          argv = [
            "kitty"
            "--title"
            "Notes"
            "-e"
            "sh"
            "-c"
            ''cd ~/notes && nix develop -c sh -c nvim''
          ];
        }
      ];
      workspaces = {
        "browse".open-on-output = "HDMI-A-1";
        "notes".open-on-output = "HDMI-A-1";
        "comms".open-on-output = "HDMI-A-1";
        "gaming".open-on-output = "HDMI-A-1";
      };
    })

    (lib.mkIf (hostName == "papyr") {
      spawn-at-startup = [
        {argv = ["sunshine"];}
        {argv = ["brave"];}
        {argv = ["signal-desktop"];}
        {argv = ["obsidian"];}
        {
          argv = [
            "kitty"
            "--title"
            "Notes"
            "-e"
            "sh"
            "-c"
            ''cd ~/notes && nix develop ${config.home.homeDirectory}/.nixos#md -c sh -c nvim''
          ];
        }
      ];
      workspaces = {
        "browse".open-on-output = "eDP-1";
        "notes".open-on-output = "eDP-1";
        "comms".open-on-output = "eDP-1";
      };
    })

    {
      window-rules = [
        {
          matches = [
            {
              app-id = "brave-browser";
              at-startup = true;
            }
            {
              app-id = "spotify";
              at-startup = true;
            }
          ];
          open-on-workspace = "browse";
          default-column-width.proportion = 0.8;
        }
        {
          matches = [
            {
              title = ".*Obsidian.*";
              app-id = "electron";
              at-startup = true;
            }
          ];
          open-on-workspace = "notes";
          default-column-width.proportion = 0.6666;
        }
        {
          matches = [
            {
              title = "Notes";
              app-id = "kitty";
              at-startup = true;
            }
          ];
          open-on-workspace = "notes";
        }
        {
          matches = [
            {
              app-id = "discord";
              at-startup = true;
            }
            {
              app-id = "signal";
              at-startup = true;
            }
          ];
          open-on-workspace = "comms";
          default-column-width.proportion = 0.6666;
        }
        {
          matches = [
            {
              app-id = "steam";
              at-startup = true;
            }
          ];
          open-on-workspace = "gaming";
          default-column-width.proportion = 0.88;
        }
      ];
    }
  ];
}
