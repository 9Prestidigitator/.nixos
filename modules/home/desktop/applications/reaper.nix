{inputs, ...}: {
  flake.homeModules.reaper = {config, ...}: {
    imports = [inputs.reaper-flake.homeModules.reaper];
    programs.reaper = {
      enable = true;
      configPath = "${config.xdg.configHome}/reaper-flake";

      extensions = {
        reapack.enable = true;
        sws.enable = true;
      };

      # pythonSupport.enable = true;
    };
  };
}
