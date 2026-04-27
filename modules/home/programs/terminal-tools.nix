{
  flake.homeModules.terminal-tools = {
    pkgs,
    config,
    osConfig,
    ...
  }: let
    logoLarge = pkgs.fetchurl {
      url = "https://gitlab.com/ntgn/ascii-art/-/raw/main/src/nixos_wrath.txt";
      hash = "sha256-dsZU4FzxdsJWRnNmCiruojZQAL01jFOQsj13hoSNvTY=";
    };
    logoSmall = pkgs.fetchurl {
      url = "https://gitlab.com/ntgn/ascii-art/-/raw/main/src/nixos_logo.txt";
      hash = "sha256-kr3HHVkuBxHoXakIgcotcr0/NtLUAQWutu+gxhZ4s1g=";
    };
  in {
    programs = {
      kitty = {
        enable = true;
        themeFile = "SpaceGray_Eighties";
        settings = {
          dynamic_background_opacity = true;
          cursor_shape = "block";
          hide_window_decorations = "yes";
          wayland_enable_ime = "yes";
          enable_audio_bell = false;
        };
      };

      fastfetch = {
        enable = true;
        settings = {
          display = {
            separator = "";
          };
          modules = [
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

      bash = {
        enable = true;
        # fastfetch
        initExtra = ''
          clear
          [ $(tput cols) -ge 120 ] && fastfetch --file-raw "${logoLarge}" --logo-padding-left $((($(tput cols) - 120) / 2))
          [ $(tput cols) -ge 78 ] && [ $(tput cols) -lt 110 ] && fastfetch --file-raw "${logoSmall}"  --logo-padding-top 3 --logo-padding-left $((($(tput cols) - 78) / 2)) --logo-padding-right 2
          [ $(tput cols) -lt 78 ] && fastfetch --logo none
        '';
      };

      zoxide.enable = true;
    };

    home = {
      sessionVariables = {
        VISUAL = "nvim";
        EDITOR = "nvim";
      };
      shellAliases = {
        ls = "ls -a --color=auto";
        fman = "compgen -c | sort -hr | fzf | xargs man";

        nhre = "nh os switch ${config.home.homeDirectory}/.nixos -H ${osConfig.networking.hostName}";
        nhbo = "nh os boot ${config.home.homeDirectory}/.nixos -H ${osConfig.networking.hostName}";
        nixre = "sudo nixos-rebuild switch ${config.home.homeDirectory}/.nixos#${osConfig.networking.hostName}";
        nixup = "nix flake update";

        tm = "tmux a || tmux";

        ds = "nix develop";
        dsv = "nix develop -c nvim";
        ds-nix = "nix develop ${config.home.homeDirectory}/.nixos#nix";
        ds-md = "nix develop ${config.home.homeDirectory}/.nixos#markdown";
        ds-cpp = "nix develop ${config.home.homeDirectory}/.nixos#cpp";
        ds-cs = "nix develop ${config.home.homeDirectory}/.nixos#csharp";
        ds-py = "nix develop ${config.home.homeDirectory}/.nixos#python";
        ds-full = "nix develop ${config.home.homeDirectory}/.nixos#default";

        nv = "nvim";
        nv-nix = "nix develop ${config.home.homeDirectory}/.nixos#nix -c nvim";
        nv-md = "nix develop ${config.home.homeDirectory}/.nixos#markdown -c nvim";
        nv-cpp = "nix develop ${config.home.homeDirectory}/.nixos#cpp -c nvim";
        nv-cs = "nix develop ${config.home.homeDirectory}/.nixos#csharp -c nvim";
        nv-py = "nix develop ${config.home.homeDirectory}/.nixos#python -c nvim";
        nv-full = "nix develop ${config.home.homeDirectory}/.nixos#default -c nvim";
      };
    };
  };
}
