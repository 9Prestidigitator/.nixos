{inputs, ...}: {
  flake.nixosModules.noctalia = {pkgs, ...}: {
    services = {
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

    programs.gpu-screen-recorder.enable = true;

    environment = {
      systemPackages = with pkgs; [
        (inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default.override {
          calendarSupport = true;
        })
        wlsunset
        wl-mirror
        cliphist
        kdePackages.breeze-icons
        kdePackages.qt6ct
        kdePackages.qttools
        grim
        slurp
        tesseract
        imagemagick
        zbar
        curl
        jq
        translate-shell
        wf-recorder
        gifski
        linux-wallpaperengine
      ];
      sessionVariables = {
        QS_ICON_THEME = "breeze-dark";
      };
    };

    persist.userDirs = [
      ".cache/noctalia"
      ".config/evolution"
      ".local/share/evolution"
    ];
  };
}
