{
  lib,
  config,
  inputs,
  pkgs,
  ...
}: let
  cfg = config.desktop;
  isNiri = cfg.enable && cfg.mode == "niri";
in {
  imports = [
    inputs.noctalia.nixosModules.default
  ];

  config = lib.mkIf isNiri {
    services.noctalia-shell.enable = true;

    home-manager.sharedModules = [
      inputs.noctalia.homeModules.default
      ./settings.nix
      ./bar.nix
      ./dock.nix
    ];
  };
}
