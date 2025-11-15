{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: let
  syncRepo = import ./sync-repo.nix {inherit pkgs;};
in {
  home.username = "max";
  home.homeDirectory = "/home/max";
  home.stateVersion = "25.05";
  # Add user home directories such as Downloads, Documents, etc.
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };

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
      eval "$(starship init bash)"
      export PS1='\[\e[38;5;76m\]\u\[\e[0m\] in \[\e[38;5;32m\]\w\[\e[0m\] \\$ '
    '';
  };

  programs.neovim = {
    enable = true;
    package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
  };

  programs.tmux = {
    enable = true;
    terminal = "tmux-256color";
    prefix = "C-b";
    keyMode = "vi";
    mouse = true;
    plugins = with pkgs; [
      tmuxPlugins.resurrect
      tmuxPlugins.nord
    ];
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

  programs.kitty = {
    enable = true;
    font = {
      name = "Hack Nerd Font";
      size = 10;
    };
    settings = {
      background_opacity = "0.5";
      dynamic_background_opacity = true;
      cursor_shape = "block";
      hide_window_decorations = "yes";
      wayland_enable_ime = "yes";
    };
  };

  home.activation.syncNvimDotfiles = lib.hm.dag.entryAfter ["writeBoundary"] ''
    $DRY_RUN_CMD ${
      syncRepo {
        url = "https://github.com/9Prestidigitator/nvim.git";
        destination = "${config.home.homeDirectory}/.config/nvim";
      }
    }
  '';

  # home.packages = with pkgs; [ tmux ];

  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.adwaita-icon-theme;
    };
    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
  };
  qt = {
    enable = true;
    platformTheme.name = "adwaita";
    style = {
      name = "adwaita-dark";
      package = pkgs.adwaita-qt;
    };
  };
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      gtk-theme = "Adwaita-dark";
    };
    "org/gnome/desktop/background" = {
      picture-uri = "file://${pkgs.nixos-artwork.wallpapers.nineish-dark-gray.src}";
      picture-uri-dark = "file://${pkgs.nixos-artwork.wallpapers.nineish-dark-gray.src}";
    };
  };
  home.sessionVariables = {
    GTK_THEME = "Adwaita-dark";
    QT_STYLE_OVERRIDE = "adwaita-dark";
  };
  systemd.user.sessionVariables = config.home.sessionVariables;
}
