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

  qt_gtk_dark_default.enable = lib.mkDefault true;
}
