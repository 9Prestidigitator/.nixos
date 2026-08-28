{
  flake.nixosModules.sway = {pkgs, ...}: {
    programs.sway = {
      enable = true;
      wrapperFeatures.gtk = true;
    };

    services = {
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
      settings.overload_tap_timeout = 25;
      main.leftmeta = "overload(meta, favorites)";
    };

    xdg.portal.enable = true;

    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1";
      MOZ_ENABLE_WAYLAND = "1";
      SDL_VIDEODRIVER = "wayland";
    };

    environment.systemPackages = with pkgs; [
      wdisplays
      wl-clipboard
      grim
      slurp
    ];
  };
}
