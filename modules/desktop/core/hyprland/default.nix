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

    # services.displayManager.ly = {
    #   enable = true;
    #   settings = {
    #     allow_empty_password = false;
    #     animation = "matrix";
    #     bigclock = "en";
    #     clock = "%c";
    #     lang = "en";
    #     numlock = true;
    #     vi_default_mode = "insert";
    #     vi_mode = true;
    #   };
    # };

    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
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
            enable = true;
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
          enable = true;
          systemd.enable = false;
          settings = {
            "$mainMod" = "SUPER";
            "$terminal" = "kitty";

            bind = [
              "$mainMod, H, movefocus, l"
              "$mainMod, L, movefocus, r"
              "$mainMod, K, movefocus, u"
              "$mainMod, J, movefocus, d"

              "$mainMod, Return, exec, $terminal"

              "$mainMod, escape, exec, caelestia shell lock lock"

              "$mainMod, TAB, workspace, previous"
              "$mainMod, D, workspace, +1"
              "$mainMod, U, workspace, -1"

              "$mainMod CONTROL, space, togglefloating"
              "$mainMod, F, fullscreen"
              "$mainMod, Q, killactive"

              "$mainMod, 1, workspace, 1"
              "$mainMod, 2, workspace, 2"
              "$mainMod, 3, workspace, 3"
              "$mainMod, 4, workspace, 4"
              "$mainMod, 5, workspace, 5"
              "$mainMod, 6, workspace, 6"
              "$mainMod, 7, workspace, 7"
              "$mainMod, 8, workspace, 8"
              "$mainMod, 9, workspace, 9"
              "$mainMod, 0, workspace, 10"
            ];
          };
        };
      }
    ];
  };
}
