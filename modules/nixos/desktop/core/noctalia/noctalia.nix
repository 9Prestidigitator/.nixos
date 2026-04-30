{inputs, ...}: {
  flake.nixosModules.noctalia = {pkgs, ...}: {
    services.gnome.evolution-data-server.enable = true;
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
  };
}
