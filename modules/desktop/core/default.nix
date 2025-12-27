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

  options.desktop.mode = lib.mkOption {
    type = lib.types.enum ["niri" "hyprland" "i3" "kde" "gnome"];
    default = "niri";
    description = "Choose your desktop experience";
  };
}
