{inputs, ...}: {
  flake.homeModules.neovim = {config, ...}: {
    imports = [inputs.maxvim.homeModules.default];
    programs.maxvim = {
      enable = true;
      config.dir = "${config.xdg.configHome}/maxvim";
    };

    nix.settings = {
      extra-substituters = ["https://nix-community.cachix.org"];
      extra-trusted-public-keys = ["nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="];
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
