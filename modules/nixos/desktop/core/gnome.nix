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
    ];

    xdg.mime.defaultApplications."inode/directory" = ["org.gnome.Nautilus.desktop"];

    persist = {
      directories = ["/var/lib/AccountsService"];
      userDirs = [
        ".local/share/gnome-shell"
        ".local/share/gnome-settings-daemon"
        ".local/share/nautilus"
        ".config/dconf"
        ".config/evolution"
        ".local/share/evolution"
        ".config/goa-1.0"
      ];
      userFiles = [".local/share/recently-used.xbel"];
    };
  };
}
