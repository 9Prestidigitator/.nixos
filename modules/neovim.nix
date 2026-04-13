{inputs, ...}: {
  flake.homeModules.neovim = {pkgs, config, ...}: {
    imports = [inputs.maxvim.homeManagerModules.default];
    programs.maxvim = {
      enable = true;
      package = pkgs.neovim;
      config.dir = "${config.xdg.configHome}/maxvim";
    };
  };
}
