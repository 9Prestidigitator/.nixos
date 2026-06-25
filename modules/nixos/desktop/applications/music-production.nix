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

      # plugins
      gvst
      neural-amp-modeler-lv2
      rubberband-lv2
      js-inflator
      amplocker
      drumlocker
      mixlocker
      mt-power-drumkit-2
      neuralnote
      pianoteq-trial
      auburn-sounds-free
      chow-tape-model
      melissa
      spice-oss
      pulse-visualizer
      minimeters
      ultimate-vocal-remover-gui

      carla
      ildaeil
      lsp-plugins
      x42-avldrums
      x42-plugins
      x42-gmsynth
      wolf-shaper
      drumgizmo
      ripplerx
      drumkv1
      guitarix
      gxplugins-lv2
      dragonfly-reverb
      surge-xt
      helm
      bespokesynth

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
      ".config/yabridgectl"
      ".config/MuseScore"
      ".config/overwitch"
      ".config/falkTX"
      "Audio Assault"
    ];
  };
}
