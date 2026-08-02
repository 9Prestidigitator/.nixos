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
        ];

        packages = [
          {
            repository = "MPL Scripts";
            category = "FX";
            name = "mpl_Toggle bypass FX with latency (PDC) higher than X samples.lua";
          }
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
