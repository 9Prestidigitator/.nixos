{
  lib,
  config,
  inputs,
  pkgs,
  ...
}: let
  noctalia-shell = inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default;
in {
  programs.niri = {
    enable = true;
    package = pkgs.niri;
  };

  home-manager.sharedModules = [
    inputs.niri.homeModules.config
    ./binds.nix
    ./settings.nix
    ./rules.nix
    {
      services.swayidle = {
        enable = true;
        package = pkgs.swayidle;
        systemdTarget = "niri.service";
        timeouts = [
          {
            timeout = 1200;
            command = "${pkgs.libnotify}/bin/notify-send 'Locking in 10 seconds'";
          }
          {
            timeout = 1210;
            command = "${noctalia-shell}/bin/noctalia-shell ipc call lockScreen lock";
          }
          {
            timeout = 1500;
            command = "${pkgs.niri} msg action power-off-monitors";
          }
          {
            timeout = 2000;
            command = "${pkgs.systemd}/bin/systemctl suspend";
          }
        ];
        events = [
          {
            event = "before-sleep";
            command = "${noctalia-shell}/bin/noctalia-shell ipc call lockScreen lock";
          }
        ];
      };
    }
  ];
}
