{
  config,
  lib,
  pkgs,
  ...
}: {
  gtk = {
    enable = true;
    colorScheme = "dark";
    theme = {
      name = "Adwaita-dark";
      package = pkgs.adwaita-icon-theme;
    };
    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
    cursorTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
  };
  qt = {
    enable = true;
    style = {
      name = "breeze";
      package = pkgs.kdePackages.breeze;
    };
  };
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      gtk-theme = "Adwaita-dark";
    };
  };
  home.sessionVariables = {
    GTK_THEME = "Adwaita-dark";
    QS_ICON_THEME = "breeze-dark";
    QT_QPA_PLATFORM = "wayland";
    QT_QPA_PLATFORMTHEME = "qt6ct";
    QT_QPA_PLATFORMTHEME_QT5 = "qt5ct";
  };
  systemd.user.sessionVariables = config.home.sessionVariables;
}
