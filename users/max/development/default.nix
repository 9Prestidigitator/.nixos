{
  lib,
  config,
  inputs,
  pkgs,
  osConfig,
  ...
}: {
  imports = [
    ./tui.nix
  ];

  home.packages = with pkgs; [
    # CLI
    git
    tree
    ripgrep
    fd
    starship
    fzf
    just
    wget
    zip
    unzip
    unrar
  ];

  programs.bash = {
    enable = true;
    shellAliases = {
      ls = "ls -a --color=auto";
      nv = "nvim";
      tm = "tmux a || tmux";
      fman = "compgen -c | sort -hr | fzf | xargs man";
      nhre = "nh os switch ${config.home.homeDirectory}/.nixos -H ${osConfig.networking.hostName}";
      gpre = "cd ${config.home.homeDirectory}/.nixos && git pull && nh os switch ${config.home.homeDirectory}/.nixos -H ${osConfig.networking.hostName}";
      nixup = "sudo nix flake update";
      nixre = "sudo nixos-rebuild switch ${config.home.homeDirectory}/.nixos#${osConfig.networking.hostName}";
      ndev = "nix develop";
      ds = "nix develop ${config.home.homeDirectory}/.nixos#default";
      ds-nix = "nix develop ${config.home.homeDirectory}/.nixos#nix";
      ds-md = "nix develop ${config.home.homeDirectory}/.nixos#md";
    };
    initExtra = ''
      clear
      if [[ $(tput cols) -ge 102 ]]; then
        [ $(tput lines) -ge 30 ] && fastfetch --logo-padding-left $((($(tput cols) - 102) / 2))
      else
        [ $(tput lines) -ge 30 ] && fastfetch --logo none
      fi
      eval "$(starship init bash)"
    '';
  };

  programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
        source = "nixos";
      };
      display = {
        separator = "";
      };
      modules = [
        "break"
        "break"
        {
          type = "custom";
          format = "┌─────────────────────────────────────────────────────┐";
          color = "white";
        }
        {
          type = "title";
          key = "                       ";
        }
        "break"
        {
          type = "os";
          key = "┌󰌽  ";
        }
        {
          type = "kernel";
          key = "└  ";
        }
        "break"
        {
          type = "uptime";
          key = "┌󰥔  ";
        }
        {
          type = "packages";
          key = "└󰏖  ";
        }
        "break"
        {
          type = "cpu";
          key = "┌  ";
        }
        {
          type = "gpu";
          key = "├󰍛  ";
        }
        {
          type = "memory";
          key = "├󰍛  ";
        }
        {
          type = "disk";
          key = "└  ";
        }
        {
          type = "custom";
          format = "└─────────────────────────────────────────────────────┘";
          color = "white";
        }
      ];
    };
  };
}
