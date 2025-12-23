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

  home-manager.sharedModules = [
    inputs.noctalia.homeModules.default
  ];

  config = lib.mkIf (isNiri || isHyprland) {
    services.noctalia-shell.enable = true;

    home-manager.sharedModules = [
      ./settings.nix
      ./bar.nix
      ./dock.nix
    ];
  };
}
