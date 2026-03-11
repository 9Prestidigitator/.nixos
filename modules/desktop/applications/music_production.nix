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

    environment.systemPackages = with pkgs; [
      # Compatibility
      wineWowPackages.yabridge
      wineWowPackages.full
      winetricks
      winePackages.fonts
      wineasio
      yabridge
      yabridgectl
      overwitch
      # DAWs
      bitwig-studio-latest
      reaper
      reaper-sws-extension
      reaper-reapack-extension
      # plugins
      lsp-plugins
      x42-avldrums
      x42-plugins
      guitarix
      gxplugins-lv2
      dragonfly-reverb
      surge
      # Utilities
      musescore
      paulxstretch
      papu
      easyeffects
      carla
      qpwgraph
    ];
  };
}
