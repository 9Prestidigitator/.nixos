{
  lib,
  config,
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./niri
    ./noctalia
    ./hyprland
    ./kde
    ./gnome
    ./i3
  ];

  options.desktop.mode = lib.mkOption {
    type = lib.types.enum ["niri" "kde" "hyprland" "gnome" "i3"];
    default = "niri";
    description = "Choose your desktop experience";
  };
}
