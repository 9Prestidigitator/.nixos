{inputs, ...}: {
  flake.nixosModules.music-production = {pkgs, ...}: let
    pkgs-25 = import inputs.nixpkgs-25 {
      system = pkgs.stdenv.hostPlatform.system;
      config.allowUnfree = true;
    };
  in {
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
      lsp-plugins
      pianoteq-trial
      x42-avldrums
      x42-plugins
      guitarix
      gxplugins-lv2
      dragonfly-reverb
      rubberband
      js-inflator
      pkgs-25.surge
      amplocker

      # Utilities
      musescore
      paulxstretch
      papu
      easyeffects
      qpwgraph

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
