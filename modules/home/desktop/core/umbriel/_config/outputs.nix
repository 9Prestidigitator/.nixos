{
  lib,
  osConfig,
  ...
}: let
  hostName = osConfig.networking.hostName;
in {
  programs.umbriel.settings.output = lib.mkMerge [
    (lib.mkIf (hostName == "papyr") {
      "eDP-1" = {
        mode = "1920x1080@60";
        position = [0 0];
        scale = 1.2;
        workspaces = "dynamic";
      };
      "HDMI-A-1" = {
        position = [1477 0];
        scale = 1.4;
        workspaces = "dynamic";
      };
    })
    (lib.mkIf (hostName == "ink") {
      "Microstep MSI G27C4 0x30333758" = {
        mode = "1920x1080@165";
        position = [1600 0];
        scale = 1;
        workspaces = "dynamic";
      };
      "Hewlett Packard HP 22cwa 6CM82100S4" = {
        mode = "1920x1080@60";
        position = [0 0];
        scale = 1.2;
        workspaces = "dynamic";
      };
    })
  ];
}
