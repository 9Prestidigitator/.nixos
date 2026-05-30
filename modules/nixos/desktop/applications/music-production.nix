{inputs, ...}: {
  flake.nixosModules.music-production = {pkgs, ...}: {
    imports = [
      inputs.musnix.nixosModules.musnix
      inputs.maxpkgs.nixosModules.overwitch
    ];
    musnix.enable = true;
    services.overwitch.enable = true;
    environment.systemPackages = with pkgs; [
      # hardware
      overwitch
      # DAWs
      bitwig6
      reaper
      reaper-sws-extension
      reaper-reapack-extension
      # plugins
      amplocker
      lsp-plugins
      x42-avldrums
      x42-plugins
      guitarix
      gxplugins-lv2
      dragonfly-reverb
      surge
      neural-amp-modeler-lv2
      # Utilities
      musescore
      paulxstretch
      papu
      easyeffects
      carla
      qpwgraph
    ];

    persist.userDirs = [
      ".vst"
      ".vst3"
      ".clap"
      ".lv2"
      ".BitwigStudio"
      ".config/REAPER"
      ".config/REAPER-backup"
      ".config/yabridgectl"
      ".config/MuseScore"
      ".config/overwitch"
      ".config/falkTX"
      "Audio Assault"
    ];
  };
}
