{inputs, ...}: {
  flake.nixosModules.niri = {pkgs, ...}: let
    pkgsStable = import inputs.nixpkgs-stable {
      system = pkgs.stdenv.hostPlatform.system;
      config = {
        allowUnfree = true;
      };
    };
  in {
    programs.niri = {
      enable = true;
      package = pkgs.niri;
    };

    # Probably going to change. Doesn't fit noctalia
    services = {
      accounts-daemon.enable = true;
      gnome.gnome-online-accounts.enable = true;
      gnome.evolution-data-server.enable = true;
      displayManager.ly = {
        enable = true;
        settings = {
          allow_empty_password = true;
          animation = "colormix";
          bigclock = "en";
          clock = "%c";
          lang = "en";
          numlock = true;
          vi_default_mode = "insert";
          vi_mode = true;
        };
      };
    };

    programs = {
      evolution.enable = true;
      dconf.enable = true;
    };

    environment.sessionVariables = {
      XDG_CURRENT_DESKTOP = "niri";
      XDG_SESSION_DESKTOP = "niri";
      NIXOS_OZONE_WL = "1";
    };

    programs.kdeconnect.enable = true;

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

  flake.homeModules.desktop = {pkgs, ...}: {
    imports = [
      inputs.niri.homeModules.config
      inputs.noctalia.homeModules.default
      (inputs.import-tree ./_niri)
    ];

    xdg = {
      portal = {
        enable = true;
        xdgOpenUsePortal = true;
        extraPortals = with pkgs; [
          xdg-desktop-portal-gnome
          xdg-desktop-portal-gtk
        ];
        configPackages = [pkgs.niri];
        config = {
          common = {
            default = [
              "gtk"
              "gnome"
            ];
          };
        };
      };
      mimeApps = {
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

  };
}
