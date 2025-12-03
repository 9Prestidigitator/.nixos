{
  pkgs,
  lib,
  inputs,
  config,
  ...
}: {
  options = {
    musicprod.enable = lib.mkEnableOption "Enables music production configuration.";
  };

  config = lib.mkIf config.musicprod.enable {
    environment.systemPackages = with pkgs; [
      bitwig-studio
      wineWowPackages.yabridge
      winePackages.fonts
      winetricks
      wineasio
      yabridge
      yabridgectl
    ];
  };
}
