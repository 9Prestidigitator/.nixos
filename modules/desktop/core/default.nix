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
    ./kde
  ];

  options.desktop.mode = lib.mkOption {
    type = lib.types.enum ["niri" "kde" "hyprland" "sway"];
    default = "niri";
    description = "Choose your desktop experience";
  };
}
