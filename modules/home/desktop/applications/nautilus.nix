{
  flake.homeModules.nautilus = {pkgs, ...}: {
    home.packages = with pkgs; [
      nautilus
      file-roller
    ];

    xdg.mimeApps.defaultApplications = {
      "inode/directory" = ["org.gnome.Nautilus.desktop"];
      "application/zip" = ["org.gnome.FileRoller.desktop"];
      "application/vnd.rar" = ["org.gnome.FileRoller.desktop"];
      "application/x-7z-compressed" = ["org.gnome.FileRoller.desktop"];
      "application/x-tar" = ["org.gnome.FileRoller.desktop"];
      "application/x-xz" = ["org.gnome.FileRoller.desktop"];
      "application/gzip" = ["org.gnome.FileRoller.desktop"];
      "application/x-bzip2" = ["org.gnome.FileRoller.desktop"];
    };

    desktop.explorer.name = "nautilus";
    persist.directories = [
      ".local/share/nautilus"
      ".config/dconf"
      ".config/gtk-3.0"
    ];
  };
}
