{ config, pkgs, inputs, lib, ... }:

let syncRepo = import /home/max/.nixos.config/sync-repo.nix { inherit pkgs; };
in {
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
      eval "$(starship init bash)"
      export PS1='\[\e[38;5;76m\]\u\[\e[0m\] in \[\e[38;5;32m\]\w\[\e[0m\] \\$ '
    '';
  };

  programs.neovim = {
    enable = true;
    package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
  };

  programs.kitty = {
    enable = true;
    font = {
      name = "Hack Nerd Font";
      size = 10;
    };
    settings = {
      background_opacity = "1";
      cursor_shape = "block";
      hide_window_decorations = "yes";
    };
  };

  home.activation.syncNvimDotfiles =
    lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      $DRY_RUN_CMD ${
        syncRepo {
          url = "https://github.com/9Prestidigitator/nvim.git";
          destination = "${config.home.homeDirectory}/.config/nvim";
        }
      }
    '';

  home.packages = with pkgs; [ tmux ];

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
      picture-uri =
        "file://${pkgs.nixos-artwork.wallpapers.nineish-dark-gray.src}";
      picture-uri-dark =
        "file://${pkgs.nixos-artwork.wallpapers.nineish-dark-gray.src}";
    };
  };
  home.sessionVariables = {
    GTK_THEME = "Adwaita-dark";
    QT_STYLE_OVERRIDE = "adwaita-dark";
  };
  systemd.user.sessionVariables = config.home.sessionVariables;
}

