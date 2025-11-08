{ config, pkgs, ... }:

{
  home.username = "max";
  home.homeDirectory = "/home/max";
  home.stateVersion = "25.05";

  programs.bash = {
    enable = true;
    shellAliases = {
      nv = "nvim";
      nrs = "sudo nixos-rebuild switch";
    };
    initExtra = ''
      export PS1='\[\e[38;5;76m\]\u\[\e[0m\] in \[\e[38;5;32m\]\w\[\e[0m\] \\$ '
    '';
  };

  home.packages = with pkgs; [
    neovim
    tmux
    git
  ];
}

