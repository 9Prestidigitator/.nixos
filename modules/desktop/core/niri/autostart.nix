{
  config,
  inputs,
  lib,
  osConfig,
  ...
}: let
  hostName = osConfig.networking.hostName;
in {
  programs.niri.settings = lib.mkMerge [
    (lib.mkIf (hostName == "ink") {
      spawn-at-startup = [
        {argv = ["brave"];}
        {argv = ["spotify"];}
        {argv = ["obsidian"];}
        {argv = ["steam"];}
        {argv = ["discord"];}
        {argv = ["signal-desktop"];}
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
        {argv = ["brave"];}
        {argv = ["spotify"];}
        {argv = ["obsidian"];}
        {argv = ["kitty" "--title" "Notes" "Neovim" "-e" "nvim" "~/notes"];}
        {argv = ["discord"];}
        {argv = ["signal-desktop"];}
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
              app-id = "Spotify";
              at-startup = true;
            }
          ];
          open-on-workspace = "browse";
        }
        {
          matches = [
            {
              app-id = "obsidian";
              at-startup = true;
            }
          ];
          open-on-workspace = "notes";
        }
        {
          matches = [
            {
              title = "notes";
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
        }
      ];
    }
  ];
}
