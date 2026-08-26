{inputs, ...}: {
  flake.nixosModules.niri = {pkgs, ...}: let
    system = pkgs.stdenv.hostPlatform.system;
  in {
    programs.niri = {
      enable = true;
      package = pkgs.niri;
    };

    services = {
      accounts-daemon.enable = true;
      gnome.gnome-online-accounts.enable = true;
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
      seahorse.enable = true;
      dconf.enable = true;
    };

    xdg.portal.enable = true;

    environment.sessionVariables = {
      XDG_CURRENT_DESKTOP = "niri";
      XDG_SESSION_DESKTOP = "niri";
      NIXOS_OZONE_WL = "1";
    };

    environment.systemPackages = with pkgs; [
      xwayland-satellite
      inputs.niri-float-sticky.packages.${system}.default
      wl-clipboard
      pulseaudio
    ];

    persist = {
      directories = ["/var/lib/AccountsService"];
      userDirs = [
        ".local/share/gvfs-metadata"
        ".config/dconf"
        ".local/share/evolution"
        ".config/evolution"
        ".config/goa-1.0"
      ];
    };
  };
}
