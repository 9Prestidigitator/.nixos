{inputs, ...}: {
  flake.homeModules.reaper = {config, ...}: let
    reaper-config-dir = "${config.xdg.configHome}/reaper-flake";
  in {
    imports = [inputs.reaper-flake.homeModules.reaper];
    programs.reaper = {
      enable = true;
      configPath = reaper-config-dir;

      extensions = {
        reapack.enable = true;
        sws.enable = true;
      };

      # pythonSupport.enable = true;
    };

    persist.directories = [reaper-config-dir];
  };
}
