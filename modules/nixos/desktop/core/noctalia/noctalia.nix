{
  flake.nixosModules.noctalia = {pkgs, ...}: {
    services = {
      gnome.evolution-data-server.enable = true;
      # Making super key tap-able
      keyd = {
        keyboards.default.settings = {
          settings.overload_tap_timeout = 25;
          main.leftmeta = "overload(meta, favorites)";
        };
        keyboards.qmk = {
          ids = ["cb10:8256" "3434:0430"];
          settings = {
            settings.overload_tap_timeout = 25;
            main.leftmeta = "overload(meta, favorites)";
          };
        };
      };
    };

    programs = {
      gpu-screen-recorder.enable = true;
      kdeconnect.enable = true;
    };

    environment = {
      systemPackages = with pkgs; [
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
        ddcutil
        mpvpaper
        linux-wallpaperengine
      ];
      sessionVariables = {
        QS_ICON_THEME = "breeze-dark";
      };
    };

    nix.settings = {
      substituters = ["https://noctalia.cachix.org"];
      trusted-public-keys = ["noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="];
    };

    persist.userDirs = [
      ".cache/noctalia"
      ".local/state/noctalia"
      ".config/evolution"
      ".local/share/evolution"
    ];
  };
}
