{
  flake.nixosModules.sway = {pkgs, ...}: {
    programs.sway = {
      enable = true;
      wrapperFeatures.gtk = true;
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
