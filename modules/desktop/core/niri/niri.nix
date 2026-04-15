{inputs, ...}: {
  flake.nixosModules.niri = {pkgs, ...}: {
    # noctalia as a dependency
    imports = [inputs.self.nixosModules.noctalia];

    programs.niri = {
      enable = true;
      package = pkgs.niri-unstable;
    };

    services = {
      accounts-daemon.enable = true;
      gnome.gnome-online-accounts.enable = true;
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

    environment.sessionVariables = {
      XDG_CURRENT_DESKTOP = "niri";
      XDG_SESSION_DESKTOP = "niri";
      NIXOS_OZONE_WL = "1";
    };

    environment.systemPackages = with pkgs; [
      inputs.xwayland-satellite.packages.${pkgs.stdenv.hostPlatform.system}.default
      seahorse
      polkit_gnome
      wl-clipboard
      file-roller
      pulseaudio
      imv
    ];
  };

  flake.homeModules.niri = {
    imports = [
      # niri-flake is responsible for the configuration and desktop portal startup
      inputs.niri-flake.homeModules.config
      (inputs.import-tree ./_config)

      # noctalia as a dependency
      inputs.self.homeModules.noctalia
    ];
  };
}
