{
  flake.homeModules.nautilus = {pkgs, ...}: {
    home.packages = with pkgs; [
      nautilus
      file-roller
    ];

    xdg.mimeApps.defaultApplications."inode/directory" = ["org.gnome.Nautilus.desktop"];

    desktop.explorer.name = "nautilus";

    persist.directories = [
      ".local/share/nautilus"
      ".config/dconf"
      ".config/gtk-3.0"
    ];
  };
}
