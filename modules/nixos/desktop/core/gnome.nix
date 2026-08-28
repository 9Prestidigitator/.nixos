{
  flake.nixosModules.gnome = {
    pkgs,
    lib,
    options,
    ...
  }: {
    config =
      {
        services = {
          desktopManager.gnome.enable = true;
        };

        services.gnome = {
          core-apps.enable = false;
          core-developer-tools.enable = false;
          games.enable = false;
        };

        environment = {
          systemPackages = with pkgs; [
            adwaita-icon-theme
            gnome-tweaks
            gnomeExtensions.blur-my-shell
            gnomeExtensions.just-perfection
            gnomeExtensions.arc-menu
            gjs
          ];
          gnome.excludePackages = with pkgs; [gnome-tour gnome-user-docs];
        };

        xdg.portal.enable = true;

        persist = {
          directories = ["/var/lib/AccountsService"];
          userDirs = [
            ".config/evolution"
            ".config/dconf"
            ".config/goa-1.0"

            ".local/share/evolution"
            ".local/share/gvfs-metadata"
            ".local/share/gnome-shell"
            ".local/share/gnome-settings-daemon"
          ];
          # userFiles = [".local/share/recently-used.xbel"];
        };
      }
      // lib.optionalAttrs (options ? stylix.icons.enable) {
        stylix.icons = {
          enable = true;
          package = pkgs.adwaita-icon-theme;
          dark = "Adwaita";
          light = "Adwaita";
        };
      };
  };
}
