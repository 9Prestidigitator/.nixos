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

  home-manager.sharedModules = [
    inputs.noctalia.homeModules.default
  ];

  options.desktop.mode = lib.mkOption {
    type = lib.types.enum ["niri" "kde" "hyprland" "sway"];
    default = "niri";
    description = "Choose your desktop experience";
  };
}
