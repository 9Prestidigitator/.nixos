{
  lib,
  config,
  inputs,
  pkgs,
  ...
}: let
  cfg = config.desktop;
  isNiri = cfg.enable && cfg.mode == "niri";
  isHyprland = cfg.enable && cfg.mode == "hyprland";
in {
  imports = [
    inputs.noctalia.nixosModules.default
  ];

  config = lib.mkIf isNiri || isHyprland {
    services.noctalia-shell.enable = true;

    home-manager.sharedModules = [
      inputs.noctalia.homeModules.default
      ./settings.nix
      ./bar.nix
      ./dock.nix
    ];
  };
}
