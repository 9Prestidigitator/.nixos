{
  lib,
  config,
  inputs,
  pkgs,
  ...
}: {
  home-manager.sharedModules = [
    inputs.noctalia.homeModules.default
    ./settings.nix
    ./bar.nix
    ./dock.nix
  ];
}
