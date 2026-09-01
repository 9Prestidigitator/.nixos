{inputs, ...}: {
  flake.nixosModules.noctalia = {pkgs, ...}: {
    imports = [inputs.noctalia.homeModules.default];
    programs = {
      noctalia = {
        enable = true;
        systemd.enable = true;
      };
      gpu-screen-recorder.enable = true;
      kdeconnect.enable = true;
    };

    environment = {
      systemPackages = with pkgs; [
        playerctl
        brightnessctl
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
        smartmontools
        hyprpicker
        linux-wallpaperengine
        qrencode
      ];
      sessionVariables.QS_ICON_THEME = "breeze-dark";
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
      ".local/share/kdeconnect"
    ];
  };
}
