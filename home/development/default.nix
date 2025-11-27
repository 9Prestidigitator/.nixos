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
    };
    initExtra = ''
      [ $(tput cols) -ge 93 ] && [ $(tput lines) -ge 30 ] && fastfetch --logo-padding-left $((($(tput cols) - 93) / 2))
      eval "$(starship init bash)"
      export PS1='\[\e[38;5;76m\]\u\[\e[0m\] in \[\e[38;5;32m\]\w\[\e[0m\] \\$ '
    '';
  };

  programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
        source = "nixos_small";
      };
      display = {
        separator = "";
      };
      modules = [
        {
          type = "custom";
          format = "\u001b[90m┌─────────────────────────────────────────────────────┐";
          color = "white";
        }
        {
          type = "title";
          format = "                        ";
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
          format = "\u001b[90m└─────────────────────────────────────────────────────┘";
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
    python315
    uv
    nodejs_24
    dotnetCorePackages.sdk_9_0-bin
    nixd
  ];
}
