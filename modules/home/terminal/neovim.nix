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

    home = {
      sessionVariables = {
        VISUAL = "nvim";
        EDITOR = "nvim";
      };
      shellAliases = {
        dsv = "nix develop -c nvim";

        nv = "nvim";
        nv-nix = "nix develop ${config.home.homeDirectory}/.nixos#nix -c nvim";
        nv-md = "nix develop ${config.home.homeDirectory}/.nixos#markdown -c nvim";
        nv-cpp = "nix develop ${config.home.homeDirectory}/.nixos#cpp -c nvim";
        nv-cs = "nix develop ${config.home.homeDirectory}/.nixos#csharp -c nvim";
        nv-py = "nix develop ${config.home.homeDirectory}/.nixos#python -c nvim";
        nv-full = "nix develop ${config.home.homeDirectory}/.nixos#default -c nvim";
      };
    };

    persist.directories = [".config/maxvim" ".local/share/maxvim" ".cache/maxvim"];
  };
}
