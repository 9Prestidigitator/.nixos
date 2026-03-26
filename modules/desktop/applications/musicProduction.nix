{inputs, ...}: {
  flake.nixosModules.musicProduction = {pkgs, ...}: {
    imports = [
      inputs.musnix.nixosModules.musnix
      inputs.self.nixosModules.overwitch
    ];
    musnix.enable = true;
    environment.systemPackages = with pkgs; [
      # Compatibility
      wineWow64Packages.yabridge
      wineWow64Packages.full
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
      # surge
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
