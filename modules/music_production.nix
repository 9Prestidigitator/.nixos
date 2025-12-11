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
      wineWowPackages.yabridge
      winetricks
      winePackages.fonts
      wineasio
      yabridge
      yabridgectl
    ];
  };
}
