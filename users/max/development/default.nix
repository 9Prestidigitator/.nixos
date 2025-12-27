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
    fzf
    wget
    starship
    ripgrep
    zip
    unzip
    unrar
    fd

    # Development
    gcc
    rustup
    python3
    uv
    nodejs_24
    dotnetCorePackages.sdk_9_0-bin
    nixd
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
      nixre = "sudo nixos-rebuild switch --upgrade --impure --flake ${config.home.homeDirectory}/.nixos#${osConfig.networking.hostName}";
    };
    initExtra = ''
      clear
      [ $(tput cols) -ge 102 ] && [ $(tput lines) -ge 30 ] && fastfetch --logo-padding-left $((($(tput cols) - 102) / 2))
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
          key = "                      ";
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
