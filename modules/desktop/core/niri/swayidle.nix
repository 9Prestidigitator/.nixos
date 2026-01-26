{
  config,
  inputs,
  lib,
  pkgs,
  osConfig,
  isLaptop,
  ...
}: let
  noctalia-shell = inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default;
in {
  services.swayidle = {
    enable = true;
    package = pkgs.swayidle;
    systemdTarget = "niri.service";
    timeouts =
      [
        {
          timeout = 1000;
          command = "${noctalia-shell}/bin/noctalia-shell ipc call lockScreen lock";
        }
        {
          timeout = 1200;
          command = "${pkgs.niri}/bin/niri msg action power-off-monitors";
        }
      ]
      ++ lib.optionals isLaptop [
        {
          timeout = 1400;
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
