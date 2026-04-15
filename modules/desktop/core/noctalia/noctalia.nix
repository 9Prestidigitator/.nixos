{inputs, ...}: {
  flake.nixosModules.noctalia = {pkgs, ...}: {
    services.gnome.evolution-data-server.enable = true;
    programs.gpu-screen-recorder.enable = true;
    environment.systemPackages = with pkgs; [
      (inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default.override {
        calendarSupport = true;
      })
      wlsunset
      wl-mirror
      cliphist
      kdePackages.breeze-icons
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
    ];
  };

  flake.homeModules.noctalia = {
    imports = [
      inputs.noctalia.homeModules.default
      (inputs.import-tree ./_config)
    ];

    services = {
      kdeconnect = {
        enable = true;
        indicator = true;
      };
    };
  };
}
