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
}
