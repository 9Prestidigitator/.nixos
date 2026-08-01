{
  programs.reaper = {
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
        ];

        promptToUninstallObsoletePackages = true;
        synchronizeOnActivation = true;
      };

      sws.enable = true;
    };
  };
}
