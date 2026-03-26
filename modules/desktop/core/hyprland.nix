{inputs, ...}: {
  flake.nixosModules.hyprland = {pkgs, ...}: {
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
      libqalculate
      app2unit
      libcava
      material-symbols
    ];
  };

  flake.homeModules.default = {
    imports = [
      inputs.caelestia-shell.homeManagerModules.default
      {
        wayland.windowManager.hyprland = {
          enable = true;
          systemd.enable = false;
        };
      }
      (inputs.import-tree ./_niri)
    ];
  };
}
