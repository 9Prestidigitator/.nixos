{inputs, ...}: {
  flake.homeModules.neovim = {
    pkgs,
    config,
    ...
  }: {
    imports = [inputs.maxvim.homeModules.default];
    programs.maxvim = {
      enable = true;
      package = pkgs.neovim;
      config.dir = "${config.xdg.configHome}/maxvim";
    };

    persist.directories = [".config/maxvim" ".local/share/maxvim" ".cache/maxvim"];
  };
}
