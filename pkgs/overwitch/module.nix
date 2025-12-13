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

    user = lib.mkOption {
      type = lib.types.str;
      default = "root";
      description = "User to run overwitch as";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [cfg.package];
    services.udev.packages = [cfg.package];

    services.udev.extraRules = ''
      SUBSYSTEM=="usb", ATTR{idVendor}=="1935", MODE="0666"
    '';

    systemd.services.overwitch = {
      description = "Overwitch overbridge Daemon";
      wantedBy = ["multi-user.target"];
      after = ["sound.target"];

      serviceConfig = {
        ExecStart = "${cfg.package}/bin/overwitch";
        Restart = "on-failure";
        User = cfg.user;
      };
    };
  };
}
