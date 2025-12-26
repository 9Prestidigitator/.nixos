{
  lib,
  config,
  inputs,
  pkgs,
  ...
}: let
  cfg = config.desktop;
  isHyprland = cfg.enable && cfg.mode == "hyprland";
in {
  config = lib.mkIf isHyprland {
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
    };

    services.displayManager.ly = {
      enable = true;
      settings = {
        allow_empty_password = false;
        animation = "cmatrix";
        bigclock = "en";
        clock = "%c";
        lang = "en";
        numlock = true;
        vi_default_mode = "insert";
        vi_mode = true;
      };
    };

    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-hyprland
      ];
    };

    environment.systemPackages = with pkgs; [
      slurp
      grim
      wl-clipboard
    ];

    home-manager.sharedModules = [
      inputs.caelestia-shell.homeModules.default
      {
        programs.caelestia = {
          enable = true;
          systemd = {
            enable = false; # if you prefer starting from your compositor
            target = "graphical-session.target";
            environment = [];
          };
          settings = {
            bar.status = {
              showBattery = false;
            };
            paths.wallpaperDir = "~/Images";
          };
          cli = {
            enable = true; # Also add caelestia-cli to path
            settings = {
              theme.enableGtk = false;
            };
          };
        };
      }

      {
        wayland.windowManager.hyprland.settings = {
          "$mainMod" = "SUPER";
          bind = [
            "$mainMod, H, movefocus, l"
            "$mainMod, L, movefocus, r"
            "$mainMod, K, movefocus, u"
            "$mainMod, J, movefocus, d"
          ];
        };
      }
    ];
  };
}
