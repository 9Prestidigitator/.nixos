{
  flake.nixosModules.gnome = {pkgs, ...}: {
    services = {
      desktopManager.gnome.enable = true;
    };

    services.gnome = {
      core-apps.enable = false;
      core-developer-tools.enable = false;
      games.enable = false;
    };
    environment.gnome.excludePackages = with pkgs; [gnome-tour gnome-user-docs];

    environment.systemPackages = with pkgs; [
      nautilus
      adwaita-icon-theme
      gnome-tweaks
      gnomeExtensions.blur-my-shell
      gnomeExtensions.just-perfection
      gnomeExtensions.arc-menu
      gjs
    ];

    xdg.mime.defaultApplications."inode/directory" = ["org.gnome.Nautilus.desktop"];

    persist = {
      directories = ["/var/lib/AccountsService"];
      userDirs = [
        ".local/share/nautilus"
        ".config/evolution"
        ".local/share/evolution"

        ".local/share/gvfs-metadata"
        ".config/dconf"
        ".config/goa-1.0"
        ".local/share/gnome-shell"
        ".local/share/gnome-settings-daemon"
      ];
      userFiles = [".local/share/recently-used.xbel"];
    };
  };
}
