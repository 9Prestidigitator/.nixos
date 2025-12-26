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
      protontricks.enable = true;
      extraCompatPackages = [pkgs.proton-ge-bin];
    };

    services.flatpak.packages = [
      "org.vinegarhq.Sober" # Roblox
    ];

    environment.systemPackages = with pkgs; [
      prismlauncher
      protontricks
      (bottles.override {removeWarningPopup = true;})
      heroic
    ];
  };
}
