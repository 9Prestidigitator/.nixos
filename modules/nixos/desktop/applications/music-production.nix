{inputs, ...}: {
  flake.nixosModules.music-production = {pkgs, ...}: {
    imports = [
      inputs.musnix.nixosModules.musnix
      inputs.maxpkgs.nixosModules.overwitch
    ];

    musnix.enable = true;
    services.overwitch.enable = true;

    environment.systemPackages = with pkgs; [
      # DAWs
      bitwig6
      reaper
      reaper-sws-extension
      reaper-reapack-extension

      # plugins
      carla
      gvst
      neural-amp-modeler-lv2
      rubberband-lv2
      js-inflator
      amplocker
      pianoteq-trial
      lsp-plugins
      x42-avldrums
      x42-plugins
      guitarix
      gxplugins-lv2
      dragonfly-reverb
      surge-xt
      helm

      # Utilities
      musescore
      paulxstretch
      papu
      easyeffects
      qjackctl

      # hardware
      overwitch
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
