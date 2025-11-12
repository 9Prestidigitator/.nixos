{ config, pkgs, inputs, nvim-config, ... }:

{
  home.username = "max";
  home.homeDirectory = "/home/max";
  home.stateVersion = "25.05";

  programs.bash = {
    enable = true;
    shellAliases = {
      nv = "nvim";
      nrs = "sudo nixos-rebuild switch";
      nixup = "sudo nixos-rebuild switch --impure --flake .";
      ls = "ls -a";
    };
    initExtra = ''
      export PS1='\[\e[38;5;76m\]\u\[\e[0m\] in \[\e[38;5;32m\]\w\[\e[0m\] \\$ '
    '';
  };

  programs.neovim = {
      enable = true;
      package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
  };

  home.file.".config/nvim".source = nvim-config;

  home.packages = [
    pkgs.tmux
    pkgs.git
  ];
}

