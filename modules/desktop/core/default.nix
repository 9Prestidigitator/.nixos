{
  lib,
  config,
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./niri
    ./hyprland
    ./kde
    ./gnome
    ./i3
  ];

  options.desktop.wayCompositor = lib.mkOption {
    type = lib.types.enum ["niri" "kde" "hyprland" "gnome"];
    default = "niri";
    description = "Choose your desktop experience";
  };
  options.desktop.x11WM = lib.mkOption {
    type = lib.types.enum ["i3"];
    default = "none";
    description = "Choose you X11 desktop experience";
  };
}
