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
      tone-3000-plugin
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
      ildaeil
      ultimate-vocal-remover-gui
      serum2
      dexed

      # carla
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
      ysfx

      # Utilities
      musescore
      paulxstretch
      papu
      easyeffects
      qjackctl
      qpwgraph

      # hardware
      elektroid
      overwitch

      glib-networking
    ];

    environment.sessionVariables.GIO_EXTRA_MODULES = ["${pkgs.glib-networking}/lib/gio/modules"];

    persist = {
      userDirs = [
        ".vst"
        ".vst3"
        ".clap"
        ".lv2"
        ".config/falkTX"
        ".config/lsp-plugins"
        ".config/MuseScore"
        ".config/TONE3000"
        ".config/overwitch"
        ".config/REAPER"
        ".config/rncbc.org"
        ".config/yabridgectl"
        ".local/state/Serum2"
        ".BitwigStudio"
        "Audio Assault"
      ];
      userFiles = [".config/Serum2Prefs.json"];
    };
  };
}
