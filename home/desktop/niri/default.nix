{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: let
  niri = inputs.niri;
in {
  home.packages = with pkgs; [
    xwayland-satellite
    xdg-desktop-portal-gnome
  ];

  imports = [
    niri.homeModules.config
    ./binds.nix
    ./settings.nix
    ./rules.nix
  ];
}
