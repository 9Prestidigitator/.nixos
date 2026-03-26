{
  flake.nixosModules.terminalTools = {pkgs, ...}: {
    programs.git.enable = true;
    environment.systemPackages = with pkgs; [
      btop
      vim
      lazygit
      lazydocker
      ripgrep
      fd
      fzf
      tree
      starship
      zoxide
      f3d
      yazi
      fd
      delta
      libqalculate
      calc
      lf
      just
      wget
      zip
      unrar
      unzip
    ];
  };

  flake.homeModules.terminalTools = {
    pkgs,
    config,
    osConfig,
    ...
  }: {
    programs.kitty = {
      enable = true;
      settings = {
        dynamic_background_opacity = true;
        cursor_shape = "block";
        hide_window_decorations = "yes";
        wayland_enable_ime = "yes";
      };
    };

    programs.bash = {
      enable = true;
      shellAliases = {
        # Standard stuff
        ls = "ls -a --color=auto";
        nv = "nvim";
        tm = "tmux a || tmux";
        fman = "compgen -c | sort -hr | fzf | xargs man";

        # Nix config stuff
        nhre = "nh os switch ${config.home.homeDirectory}/.nixos -H ${osConfig.networking.hostName}";
        nixup = "nix flake update";
        nixre = "sudo nixos-rebuild switch ${config.home.homeDirectory}/.nixos#${osConfig.networking.hostName}";

        # Development Shell commands
        ds = "nix develop";
        dsv = "nix develop -c nvim";
        ds-full = "nix develop ${config.home.homeDirectory}/.nixos#default";
        ds-nix = "nix develop ${config.home.homeDirectory}/.nixos#nix";
        ds-md = "nix develop ${config.home.homeDirectory}/.nixos#md";
        ds-py = "nix develop ${config.home.homeDirectory}/.nixos#python";
      };
      # fastfetch
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

    programs.tmux = {
      enable = true;
      terminal = "tmux-256color";
      prefix = "C-b";
      keyMode = "vi";
      mouse = true;
      plugins = with pkgs; [
        tmuxPlugins.resurrect
        tmuxPlugins.catppuccin
      ];
      escapeTime = 0;
      extraConfig = ''
        bind-key h select-pane -L
        bind-key l select-pane -R
        bind-key j select-pane -D
        bind-key k select-pane -U
        bind-key a last-window
        bind-key J swap-window -t -1 -d
        bind-key K swap-window -t +1 -d
        bind-key Tab switch-client -l
        bind-key -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "xclip -i -selection clipboard"
        set-option -g set-clipboard on
        set-option -g focus-events on
        set-option -g status-position top
        set-option -g status-style bg=default
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
  };
}
