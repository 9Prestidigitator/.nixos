{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: {
  imports = [
    inputs.niri.homeModules.config
    ./binds.nix
    ./settings.nix
    ./rules.nix
  ];
}
