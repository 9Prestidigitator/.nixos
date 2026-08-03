{pkgs, ...}: let
  globalSamplerSettings = {
    theme = "theme_rainbow";
    waveform_zoom = 1;
    window_state = 1;
  };
in {
  programs.reaper = {
    packages = with pkgs; [
      freetype
      libpng
      zlib
      fontconfig
      libepoxy
      gtk3
      cairo
      glib
      stdenv.cc.cc.lib
    ];

    extensions = {
      reapack = {
        enable = true;

        repositories = [
          {
            name = "reaper-keys";
            url = "https://github.com/gwatcha/reaper-keys/raw/master/index.xml";
          }
          {
            name = "Sexan_Scripts";
            url = "https://github.com/GoranKovac/ReaScripts/raw/master/index.xml";
          }
          {
            name = "Helgobox";
            url = "https://github.com/helgoboss/reaper-packages/raw/master/index.xml";
          }
          {
            name = "Bird-Bird";
            url = "https://github.com/Bird-Bird/ReaScript_Testing/raw/main/index.xml";
          }
          {
            name = "Saike Tools";
            url = "https://github.com/JoepVanlier/JSFX/raw/master/index.xml";
          }
          {
            name = "Suzuki Scripts";
            url = "https://github.com/Suzuki-Re/Suzuki-Scripts/raw/master/index.xml";
          }
          {
            name = "Reaticulate";
            url = "https://reaticulate.com/index.xml";
          }
        ];

        packages = [
          {
            repository = "ReaTeam Extensions";
            category = "API";
            name = "js_ReaScriptAPI.ext";
          }
          {
            repository = "ReaTeam Extensions";
            category = "API";
            name = "reaper_imgui.ext";
          }
          {
            repository = "Suzuki Scripts";
            category = "lewloiwc's Splitter Suite";
            name = "lewloiwc's Splitter Suite.jsfx";
          }
          {
            repository = "ReaTeam JSFX";
            category = "Modulation";
            name = "snjuk2_LFO.jsfx";
          }
          {
            repository = "Saike Tools";
            category = "Basics";
            name = "BandSplitter.jsfx";
          }
          {
            repository = "Sexan_Scripts";
            category = "FX";
            name = "Sexan_FX_Browser_ParserV7.lua";
          }
          {
            repository = "Sexan_Scripts";
            category = "ImGui_Tools";
            name = "FileManager.lua";
          }
          {
            repository = "MPL Scripts";
            category = "FX";
            name = "mpl_Toggle bypass FX with latency (PDC) higher than X samples.lua";
          }
          {
            repository = "X-Raym Scripts";
            category = "JSFX";
            name = "X-Raym_Tap tempo.lua";
          }
          {
            repository = "ReaTeam Scripts";
            category = "MIDI Editor";
            name = "Lokasenna_MIDI Randomization Tool.lua";
          }
          {
            repository = "Sexan_Scripts";
            category = "ParanormalFX";
            name = "Sexan_ParaNormal_FX_Router.lua";
          }
          {
            repository = "Bird-Bird";
            category = "Global Sampler";
            name = "BirdBird_Global Sampler.lua";
          }
          {
            repository = "Bird-Bird";
            category = "FX Inspector";
            name = "BirdBird_FX Inspector.lua";
          }
          {
            repository = "Bird-Bird";
            category = "Envelope Palette";
            name = "BirdBird_Envelope Palette.lua";
          }
          {
            repository = "Bird-Bird";
            category = "Track Tags";
            name = "BirdBird_Track Tags.lua";
          }
          {
            repository = "Bird-Bird";
            category = "FX Mangler";
            name = "BirdBird_FX Mangler.lua";
          }
          {
            repository = "Bird-Bird";
            category = "Item Modifiers";
            name = "BirdBird_Item Modifiers.lua";
          }
          {
            repository = "Bird-Bird";
            category = "Functional Console";
            name = "BirdBird_Functional Console.lua";
          }
          {
            repository = "Helgobox";
            category = "Extensions";
            name = "ReaLearn-x64";
          }
          {
            repository = "Reaticulate";
            category = "MIDI Articulations";
            name = "Reaticulate: an articulation management system for REAPER";
          }
        ];

        promptToUninstallObsoletePackages = true;
        synchronizeOnActivation = true;
      };

      sws.enable = true;
    };

    # Ugggh yet another config file to manage...
    resourceFiles.files."Scripts/Bird-Bird/Global Sampler/global_sampler_libraries/sampler_settings.json" = pkgs.writeText "global-sampler-settings.json" (builtins.toJSON globalSamplerSettings);
  };
}
