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
      ];
      workspaces = {
        "browse".open-on-output = "HDMI-A-1";
        "notes".open-on-output = "HDMI-A-1";
        "comms".open-on-output = "HDMI-A-1";
        "gaming".open-on-output = "HDMI-A-1";
      };
      window-rules = [
        {
          matches = [
            {
              app-id = "brave-browser";
              at_startup = true;
            }
          ];
          open-on-workspace = "browse";
        }
      ];
    })

    (lib.mkIf (hostName == "papyr") {
      spawn-at-startup = [
        {argv = ["brave"];}
        {argv = ["spotify"];}
        {argv = ["obsidian"];}
      ];
      workspaces = {
        "browse".open-on-output = "eDP-1";
        "notes".open-on-output = "eDP-1";
        "comms".open-on-output = "eDP-1";
      };
    })
  ];
}
