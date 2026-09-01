{
  lib,
  osConfig,
  ...
}: let
  hostName = osConfig.networking.hostName;
in {
  wayland.windowManager.mango.settings.monitorrule = lib.concatLists [
    (lib.optionals (hostName == "ink") [
      "make:Microstep,model:MSI G27C4,serial:0x30333758,width:1920,height:1080,refresh:165.003,x:1600,y:0,scale:1"
      "make:Hewlett Packard,model:HP 22cwa,serial:6CM82100S4,width:1920,height:1080,refresh:60,x:0,y:0,scale:1.2"
    ])

    (lib.optionals (hostName == "papyr") [
      "name:^eDP-1$,width:1920,height:1080,x:0,y:0,scale:1.3"
      "name:^HDMI-A-1$,scale:1.4"
    ])
  ];
}
