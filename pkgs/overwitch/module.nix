{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.services.overwitch;
in {
  options.services.overwitch = {
    enable = lib.mkEnableOption "Overwitch Overbridge daemon";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.overwitch;
      description = "Overwitch package to use";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [cfg.package];
    services.udev.packages = [cfg.package];

    services.udev.extraRules = ''
      SUBSYSTEM=="usb", ATTR{idVendor}=="1935", MODE="0666"
    '';

    # systemd.user.services.overwitch = {
    #   description = "Overwitch overbridge Daemon";
    #   wantedBy = ["default.target"];
    #   after = [
    #     "pipewire.service"
    #   ];
    #
    #   serviceConfig = {
    #     ExecStart = "${cfg.package}/bin/overwitch-service";
    #     Restart = "on-failure";
    #   };
    # };
  };
}
