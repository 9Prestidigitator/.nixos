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
      withUWSM = true;
      xwayland.enable = true;
    };

    services.displayManager.ly = {
      enable = true;
      settings = {
        allow_empty_password = false;
        animation = "matrix";
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
      inputs.caelestia-shell.homeManagerModules.default
      {
        programs.caelestia = {
          enable = true;
          systemd = {
            enable = false;
            target = "graphical-session.target";
            environment = [];
          };
          settings = {
            bar.status = {
              showBattery = false;
            };
            paths.wallpaperDir = "~/Pictures/Wallpapers";
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
        wayland.windowManager.hyprland = {
          systemd.enable = false;
          settings = {
            "$mainMod" = "SUPER";
            "$terminal" = "kitty";

            bind = [
              "$mainMod, H, movefocus, l"
              "$mainMod, L, movefocus, r"
              "$mainMod, K, movefocus, u"
              "$mainMod, J, movefocus, d"

              "$mainMod, escape, exec, caelestia shell lock lock"

              "$mainMod CONTROL, space, togglefloating"

              "$mainMod, Return, exec, $terminal"
            ];
          };
        };
      }
    ];
  };
}
