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

    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-hyprland
      ];
    };

    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      theme = "catppuccin-mocha-mauve";
    };

    environment.systemPackages = with pkgs; [
      slurp
      grim
      grimblast
      wl-clipboard
      catppuccin-sddm
    ];

    home-manager.sharedModules = [
      inputs.caelestia-shell.homeManagerModules.default
      ./caelestia.nix

      {
        wayland.windowManager.hyprland = {
          enable = true;
          systemd.enable = false;
        };
      }
      ./settings.nix
      ./binds.nix
      ./rules.nix
      ./outputs.nix
    ];
  };
}
