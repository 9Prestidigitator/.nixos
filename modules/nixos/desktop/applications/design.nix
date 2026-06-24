{
  flake.nixosModules.design = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      inkscape-with-extensions
      gimp-with-plugins
      krita
      krita-plugin-gmic
      libreoffice-qt
      hunspell
    ];

    persist = {
      userDirs = [
        ".config/GIMP"
        ".cache/gimp"
        ".config/libreoffice"
        ".config/inkscape"
        ".cache/inkscape"
        ".local/share/inkscape"
        ".local/share/krita"
        ".cache/krita"
        ".local/share/libreoffice"
      ];
      userFiles = [
        {
          file = ".config/kritarc";
          how = "symlink";
          configureParent = true;
        }
        {
          file = ".config/kritadisplayrc";
          how = "symlink";
          configureParent = true;
        }
      ];
    };
  };
}
