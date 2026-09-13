{
  flake.homeModules.dolphin = {pkgs, ...}: {
    home.packages = with pkgs.kdePackages; [
      dolphin
      dolphin-plugins
      ark
    ];

    xdg.mimeApps.defaultApplications = {
      "inode/directory" = ["org.kde.dolphin.desktop"];
      "application/zip" = ["org.kde.ark.desktop"];
      "application/vnd.rar" = ["org.kde.ark.desktop"];
      "application/x-7z-compressed" = ["org.kde.ark.desktop"];
      "application/x-tar" = ["org.kde.ark.desktop"];
      "application/x-xz" = ["org.kde.ark.desktop"];
      "application/gzip" = ["org.kde.ark.desktop"];
      "application/x-bzip2" = ["org.kde.ark.desktop"];
    };

    desktop.explorer.name = "dolphin";
    persist = {
      directories = [
        ".local/share/dolphin"
      ];
      kdeFiles = [
        ".config/dolphinrc"
        ".local/state/dolphinstaterc"
        ".local/share/user-places.xbel"
      ];
    };
  };
}
