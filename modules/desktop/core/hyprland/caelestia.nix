{
  config,
  inputs,
  lib,
  osConfig,
  ...
}: let
  isLaptop = osConfig.networking.hostName != "ink";
in {
  programs.caelestia = {
    enable = true;
    systemd = {
      enable = true;
      target = "graphical-session.target";
      environment = [];
    };
    settings = {
      general = {
        apps = {
          terminal = ["kitty"];
          explorer = ["nautilus"];
        };
        idle = {
          lockBeforeSleep = true;
          inhibitWhenAudio = true;
          timeouts = [
            {
              timeout = 1200;
              idleAction = "lock";
            }
            {
              timeout = 1500;
              idleAction = "dpms off";
              returnAction = "dpms on";
            }
            {
              timeout = 2000;
              idleAction = ["systemctl" "suspend-then-hibernate"];
            }
          ];
        };
      };
      bar.status = {
        showBattery =
          if isLaptop
          then true
          else false;
      };
      paths.wallpaperDir = "~/Pictures/Wallpapers";
    };
    cli = {
      enable = true; # Also add caelestia-cli to path
      settings = {
        theme.enableGtk = false;
      };
    };
  };
}
