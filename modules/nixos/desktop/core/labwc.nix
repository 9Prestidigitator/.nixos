{
  flake.nixosModules.labwc = {
    pkgs,
    lib,
    options,
    ...
  }: {
    config =
      {
        programs.labwc.enable = true;

        xdg.portal.enable = true;

        environment.sessionVariables = {
          NIXOS_OZONE_WL = "1";
          MOZ_ENABLE_WAYLAND = "1";
          SDL_VIDEODRIVER = "wayland";
        };

        environment.systemPackages = with pkgs; [
          wdisplays
          wl-clipboard
        ];
      }
      // lib.optionalAttrs (options ? stylix.opacity) {
        stylix.opacity = {
          desktop = 1.0;
          terminal = 1.0;
          applications = 1.0;
          popups = 1.0;
        };
      };
  };
}
