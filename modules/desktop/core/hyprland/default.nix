{
  lib,
  config,
  inputs,
  pkgs,
  ...
}: {
  programs.hyprland = {
    enable = true;
    package = pkgs.hyprland;
  };
}
