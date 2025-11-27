{
  lib,
  config,
  niri,
  ...
}: {
  imports = [
    ./niri
    ./noctalia.nix
    ./darkmode.nix
  ];
}
