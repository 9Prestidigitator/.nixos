{
  pkgs,
  lib,
  inputs,
  config,
  ...
}: {
  imports = [
    inputs.musnix.nixosModules.musnix
  ];

  config = lib.mkIf config.musicprod.enable {
    musnix = {
      enable = true;
    };
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
    ];
  };
}
