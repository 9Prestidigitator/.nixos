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

  options = {
    musicprod.enable = lib.mkEnableOption "Enables music production configuration.";
  };

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
