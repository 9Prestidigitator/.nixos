{inputs, ...}: {
  flake.nixosModules.niri = {pkgs, ...}: {
    programs.niri = {
      enable = true;
      package = pkgs.niri;
    };

    # Probably going to change. Doesn't fit noctalia
    services = {
      accounts-daemon.enable = true;
      gnome.gnome-online-accounts.enable = true;
      gnome.evolution-data-server.enable = true;
      # Making super key tap-able
      keyd = {
        keyboards.default.settings.main.leftmeta = "overload(meta, favorites)";
        keyboards.qmk = {
          ids = [
            "cb10:8256"
            "3434:0430"
          ];
          settings.main.leftmeta = "overload(meta, favorites)";
        };
      };
    };

    programs = {
      evolution.enable = true;
      dconf.enable = true;
    };

    xdg = {
      portal = {
        enable = true;
        xdgOpenUsePortal = true;
        extraPortals = with pkgs; [
          xdg-desktop-portal-gnome
          xdg-desktop-portal-gtk
        ];
        config = {
          common = {
            default = [
              "gtk"
              "gnome"
            ];
          };
        };
      };
      mime = {
        defaultApplications = {
          "x-scheme-handler/http" = ["com.brave.Browser.desktop"];
          "x-scheme-handler/https" = ["com.brave.Browser.desktop"];
          "application/pdf" = [
            "org.pwmt.zathura.desktop"
            "com.brave.Browser.desktop"
          ];
          "inode/directory" = ["org.gnome.Nautilus.desktop"];
          "image/png" = ["imv.desktop"];
        };
      };
    };

    environment.sessionVariables = {
      XDG_CURRENT_DESKTOP = "niri";
      XDG_SESSION_DESKTOP = "niri";
      NIXOS_OZONE_WL = "1";
    };

    environment.systemPackages = with pkgs; [
      (inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default.override {calendarSupport = true;})
      inputs.xwayland-satellite.packages.${pkgs.stdenv.hostPlatform.system}.default
      seahorse
      polkit_gnome
      gpu-screen-recorder
      wl-clipboard
      wl-mirror
      wlsunset
      kdePackages.breeze-icons
      linux-wallpaperengine
      xdg-desktop-portal-gnome
      cliphist
      pulseaudio
      imv
      kdePackages.qttools
      grim
      slurp
      tesseract
      imagemagick
      zbar
      curl
      translate-shell
      wf-recorder
      gifski
    ];
  };

  flake.homeModules.niri = {pkgs, ...}: {
    imports = [
      inputs.niri.homeModules.config
      inputs.noctalia.homeModules.default
      (inputs.import-tree ./_config)
    ];
  };
}
