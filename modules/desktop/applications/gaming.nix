{
  pkgs,
  lib,
  inputs,
  config,
  ...
}: {
  config = lib.mkIf config.desktop.gaming.enable {
    programs.steam = {
      enable = true;
      protontricks.enable = false; # BROKEN
    };

    services.flatpak.packages = [
      "org.vinegarhq.Sober" # Roblox
      "com.github.Matoking.protontricks" # Not ideal but works great
    ];

    environment.systemPackages = with pkgs; [
      prismlauncher
      (bottles.override {removeWarningPopup = true;})
      heroic
    ];
  };
}
