{
  lib,
  osConfig,
  ...
}: let
  hostName = osConfig.networking.hostName;

  outputSettings =
    if hostName == "ink"
    then [
      {
        output = {
          criteria = "Microstep MSI G27C4 0x30333758";
          mode = "1920x1080@165.003Hz";
          position = "1600,0";
          scale = 1.0;
        };
      }
      {
        output = {
          criteria = "Hewlett Packard HP 22cwa 6CM82100S4";
          mode = "1920x1080@60Hz";
          position = "0,0";
          scale = 1.2;
        };
      }
    ]
    else if hostName == "papyr"
    then [
      {
        output = {
          criteria = "eDP-1";
          mode = "1920x1080";
          position = "0,0";
          scale = 1.3;
        };
      }
      {
        output = {
          criteria = "HDMI-A-1";
          scale = 1.4;
        };
      }
    ]
    else if hostName == "book"
    then [
      {
        output = {
          criteria = "eDP-1";
          mode = "1366x768";
          position = "0,0";
          scale = 1.1;
        };
      }
    ]
    else if hostName == "surface"
    then [
      {
        output = {
          criteria = "eDP-1";
          mode = "1920x1080";
          position = "0,0";
          scale = 2.2;
        };
      }
    ]
    else if hostName == "vm"
    then [
      {
        output = {
          criteria = "Red Hat, Inc. QEMU Monitor Unknown";
          mode = "1920x1080";
          position = "0,0";
          scale = 1.5;
        };
      }
    ]
    else [];

in {
  services.kanshi = lib.mkIf (outputSettings != []) {
    enable = true;
    systemdTarget = "labwc-session.target";
    settings = outputSettings;
  };
}
