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
      # kernel.realtime = true;
    };
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
