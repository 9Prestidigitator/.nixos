{
  config,
  inputs,
  lib,
  osConfig,
  ...
}: let
  hostName = osConfig.networking.hostName;
in {
  programs.niri.settings.outputs = lib.mkMerge [
    (lib.mkIf (hostName == "ink") {
      "Microstep MSI G27C4 0x30333758" = {
        focus-at-startup = true;
        scale = 1;
        position = {
          x = 0;
          y = 0;
        };
        mode = {
          width = 1920;
          height = 1080;
          refresh = 165.003;
        };
      };
      "Hewlett Packard HP 22cwa 6CM82100S4" = {
        scale = 1.2;
        position = {
          x = -1600;
          y = 0;
        };
        mode = {
          width = 1920;
          height = 1080;
          refresh = 60.000;
        };
      };
    })

    (lib.mkIf (hostName == "papyr") {
      "eDP-1" = {
        scale = 1.3;
        position = {
          x = 0;
          y = 0;
        };
        mode = {
          width = 1920;
          height = 1080;
          refresh = null;
        };
      };
    })

    (lib.mkIf (hostName == "book") {
      "eDP-1" = {
        scale = 1.1;
        position = {
          x = 0;
          y = 0;
        };
        mode = {
          width = 1366;
          height = 768;
          refresh = null;
        };
      };
    })

    (lib.mkIf (hostName == "surface") {
      "eDP-1" = {
        scale = 2.2;
        position = {
          x = 0;
          y = 0;
        };
        mode = {
          width = 1920;
          height = 1080;
          refresh = null;
        };
      };
    })

    (lib.mkIf (hostName == "vm") {
      "Red Hat, Inc. QEMU Monitor Unknown" = {
        scale = 1.5;
        position = {
          x = 0;
          y = 0;
        };
        mode = {
          width = 1920;
          height = 1080;
          refresh = null;
        };
      };
    })
  ];
}
