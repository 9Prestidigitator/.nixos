{inputs, ...}: {
  flake.nixosModules.mango = {pkgs, ...}: {
    imports = [inputs.mangowm.nixosModules.mango];

    programs.mango.enable = true;

    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1";
      MOZ_ENABLE_WAYLAND = "1";
      SDL_VIDEODRIVER = "wayland";
    };

    xdg.portal.enable = true;

    environment.systemPackages = with pkgs; [
      wdisplays
      wl-clipboard
    ];
  };
}
