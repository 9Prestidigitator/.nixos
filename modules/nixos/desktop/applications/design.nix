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

    xdg.mime.defaultApplications = {
      "application/vnd.openxmlformats-officedocument.wordprocessingml.document" = ["writer.desktop"];
      "application/vnd.ms-excel" = ["calc.desktop"]; # .xls
      "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" = ["calc.desktop"]; # .xlsx
      "application/vnd.ms-excel.sheet.binary.macroEnabled.12" = ["calc.desktop"]; # .xlsb
      "application/vnd.ms-excel.sheet.macroEnabled.12" = ["calc.desktop"]; # .xlsm
      "application/vnd.openxmlformats-officedocument.spreadsheetml.template" = ["calc.desktop"]; # .xltx
      "application/vnd.oasis.opendocument.spreadsheet" = ["calc.desktop"]; # .ods
    };
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
      kdeUserFiles = [
        ".config/kritarc"
        ".config/kritadisplayrc"
      ];
    };
  };
}
