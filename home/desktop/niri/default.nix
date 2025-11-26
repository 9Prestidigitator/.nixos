{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: let
  niri = inputs.niri;
in {
  imports = [
    niri.homeModules.config
    ./binds.nix
    ./settings.nix
    ./rules.nix
  ];
}
