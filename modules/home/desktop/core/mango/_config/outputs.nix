{
  lib,
  osConfig,
  ...
}: let
  hostName = osConfig.networking.hostName;
in {
  wayland.windowManager.mango.settings.monitorrule = lib.optionals (hostName == "papyr") [
    "name:^eDP-1$,width:1920,height:1080,x:0,y:0,scale:1.3"
    "name:^HDMI-A-1$,scale:1.4"
  ];
}
