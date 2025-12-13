{
  lib,
  config,
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./noctalia
    ./niri
  ];
}
