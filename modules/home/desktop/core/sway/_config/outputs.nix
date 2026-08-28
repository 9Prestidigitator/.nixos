{
  lib,
  osConfig,
  ...
}: let
  hostName = osConfig.networking.hostName;
in {
  wayland.windowManager.sway.config.output = lib.mkMerge [
    (lib.mkIf (hostName == "papyr") {
      "eDP-1" = {
        mode = "1920x1080";
        scale = "1.3";
        pos = "0 0";
      };
      "HDMI-A-1" = {
        scale = "1.4";
      };
    })
  ];
}
