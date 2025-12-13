{
  lib,
  config,
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./noctalia.nix
    # ./niri
  ];
}
