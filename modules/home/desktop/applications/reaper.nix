{inputs, ...}: {
  flake.homeModules.reaper = {config, ...}: let
    reaper-config = "reaper-flake";
  in {
    imports = [inputs.reaper-flake.homeModules.reaper];
    programs.reaper = {
      enable = true;
      configPath = "${config.xdg.configHome}/${reaper-config}";

      extensions = {
        reapack.enable = true;
        sws.enable = true;
      };

      pythonSupport.enable = true;
    };

    persist.directories = [".config/${reaper-config}"];
  };
}
