{ config, pkgs, inputs, ... }:

{
  home.username = "max";
  home.homeDirectory = "/home/max";
  home.stateVersion = "25.05";

  programs.bash = {
    enable = true;
    shellAliases = {
      ls = "ls -a --color=auto";
      nv = "nvim";
      tm = "tmux a || tmux";
      nrs = "sudo nixos-rebuild switch";
      nixup = "sudo nixos-rebuild switch --impure --flake .";
    };
    initExtra = ''
      fastfetch
      export PS1='\[\e[38;5;76m\]\u\[\e[0m\] in \[\e[38;5;32m\]\w\[\e[0m\] \\$ '
    '';
  };

  programs.neovim = {
      enable = true;
      package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
  };

  home.file.".config/nvim" = {
      source = builtins.fetchGit {
          url = "https://github.com/9Prestidigitator/nvim.git";
          ref = "main";
      };
      recursive = true;
  };

  home.packages = [
    pkgs.tmux
    pkgs.git
  ];
}

