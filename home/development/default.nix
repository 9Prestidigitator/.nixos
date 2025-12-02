{
  username,
  config,
  pkgs,
  inputs,
  lib,
  ...
}: {
  imports = [
    ./tui.nix
  ];

  programs.bash = {
    enable = true;
    shellAliases = {
      ls = "ls -a --color=auto";
      nv = "nvim";
      tm = "tmux a || tmux";
      nrs = "sudo nixos-rebuild switch";
      nixup = "sudo nixos-rebuild switch --impure --flake .";
      nixup-king = "sudo nixos-rebuild switch --impure --flake .#KingSpec";
    };
    initExtra = ''
      [ $(tput cols) -ge 102 ] && [ $(tput lines) -ge 30 ] && fastfetch --logo-padding-left $((($(tput cols) - 102) / 2))
      eval "$(starship init bash)"
      export PS1='\[\e[38;5;76m\]\u\[\e[0m\] in \[\e[38;5;32m\]\w\[\e[0m\] \\$ '
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

  home.packages = with pkgs; [
    # CLI
    git
    tree
    wget
    starship
    ripgrep
    unzip
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
}
