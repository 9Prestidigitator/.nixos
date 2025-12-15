{
  lib,
  config,
  inputs,
  pkgs,
  ...
}: {
  config = lib.mkIf config.desktop.enable {
    home-manager.sharedModules = [
      inputs.noctalia.homeModules.default
      ./settings.nix
      ./bar.nix
      ./dock.nix
    ];
  };
}
