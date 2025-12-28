{
  config,
  inputs,
  lib,
  osConfig,
  ...
}: let
  hostName = osConfig.networking.hostName;
in {
  wayland.windowManager.hyprland.settings.monitor = lib.mkMerge [
    (lib.mkIf (hostName == "ink") [
      "desc:Microstep MSI G27C4 0x30333758,       1920x1080@165,  auto-right,   1"
      "desc:Hewlett Packard HP 22cwa 6CM82100S4,  1920x1080@60,   auto-left,    1.25"
    ])

    (lib.mkIf (hostName == "papyr") [
      "eDP-1,                                     1920x1080,      0x0,      1.25"
      "HDMI-A-1,                                  preferred,      auto,     1,    mirror,   eDP-1"
    ])

    (lib.mkIf (hostName == "surface") [
      "eDP-1,                                     2736x1824,      0x0,      2.2"
    ])

    (lib.mkIf (hostName == "vm") [
      "desc:Red Hat Inc. QEMU Monitor,            1920x1080,      0x0,      1.25"
    ])
  ];
}
