{
  lib,
  config,
  inputs,
  pkgs,
  ...
}: let
  cfg = config.desktop;
  isNiri = cfg.enable && cfg.wayCompositor == "niri";
in {
  imports = [
    inputs.noctalia.nixosModules.default
  ];

  config = lib.mkIf isNiri {
    services.noctalia-shell.enable = true;

    environment.systemPackages = [
      (inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default.override {
        calendarSupport = true;
      })
    ];

    home-manager.sharedModules = [
      inputs.noctalia.homeModules.default
      ./settings.nix
      ./bar.nix
      ./dock.nix
    ];
  };
}
