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
      adwaita-icon-theme
      gnome-tweaks
      gnomeExtensions.blur-my-shell
      gnomeExtensions.just-perfection
      gnomeExtensions.arc-menu
    ];
  };

  flake.homeModules.gnome = {
    dconf.settings."org/gnome/shell".enabled-extensions = [
      "blur-my-shell@aunetx"
      "arcmenu@arcmenu.com"
      "just-perfection-desktop@just-perfection"
    ];
  };
}
