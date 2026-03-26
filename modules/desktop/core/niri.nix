{inputs, ...}: {
  flake.nixosModules.niri = {pkgs, ...}: {
    programs.niri = {
      enable = true;
      package = pkgs.niri;
    };

    # Probably going to change. Doesn't fit noctalia
    services = {
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
      accounts-daemon.enable = true;
      gnome.gnome-online-accounts.enable = true;
      gnome.evolution-data-server.enable = true;
    };

    programs = {
      evolution.enable = true;
      dconf.enable = true;
    };

    xdg = {
      portal = {
        enable = true;
        configPackages = [
          pkgs.niri
        ];
        extraPortals = [
          pkgs.xdg-desktop-portal-gtk
          pkgs.xdg-desktop-portal-gnome
        ];
        config.common.default = ["gtk" "gnome"];
        xdgOpenUsePortal = true;
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

    programs.kdeconnect.enable = true;

    environment.systemPackages = with pkgs; [
      inputs.xwayland-satellite.packages.${pkgs.stdenv.hostPlatform.system}.default
      (inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default.override {calendarSupport = true;})
      seahorse
      polkit_gnome
      gpu-screen-recorder
      wl-clipboard
      wl-mirror
      wlsunset
      kdePackages.breeze-icons
      linux-wallpaperengine
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

  flake.homeModules.desktop = {
    imports = [
      inputs.niri.homeModules.config
      (inputs.import-tree ./_niri)
    ];
  };
}
