{
  pkgs,
  lib,
  inputs,
  config,
  ...
}: {
  imports = [
    inputs.musnix.nixosModules.musnix
    inputs.self.nixosModules.overwitch
  ];

  config = lib.mkIf config.desktop.musicprod.enable {
    musnix.enable = true;

    services.overwitch.enable = true;

    environment.systemPackages = with pkgs; [
      bitwig-studio
      reaper
      reaper-sws-extension
      reaper-reapack-extension
      wineWowPackages.yabridge
      wineWowPackages.full
      winetricks
      winePackages.fonts
      wineasio
      yabridge
      yabridgectl
      overwitch
    ];
  };
}
