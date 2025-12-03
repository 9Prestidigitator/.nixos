{
  config,
  lib,
  pkgs,
  ...
}: {
  gtk = {
    enable = true;
#   colorScheme = "dark";
#   theme = {
#     name = "breeze-dark";
#     package = pkgs.kdePackages.breeze-gtk;
#   };
    iconTheme = {
      name = "breeze-dark";
      package = pkgs.kdePackages.breeze-gtk;
    };
    cursorTheme = {
      name = "breeze_cursors";
      package = pkgs.kdePackages.breeze;
    };
  };
# qt = {
#   enable = true;
#   platformTheme.name = "gtk";
#   style = {
#     name = "breeze";
#     package = pkgs.kdePackages.breeze;
#   };
# };
  home.pointerCursor = {
    name = "breeze_cursors";
    package = pkgs.kdePackages.breeze;
    size = 24;
    x11.enable = true;
  };
  # dconf.settings = {
  #   "org/gnome/desktop/interface" = {
  #     color-scheme = "prefer-dark";
  #     gtk-theme = "breeze-dark";
  #   };
  # };
  home.sessionVariables = {
    QS_ICON_THEME = "breeze-dark";
    # GTK_THEME = "breeze-dark";
    # QT_STYLE_OVERRIDE = "breeze-dark";
    # QT_QPA_PLATFORM = "wayland";
    # QT_QPA_PLATFORMTHEME = "qt6ct";
    # QT_QPA_PLATFORMTHEME_QT5 = "qt5ct";
  };
  systemd.user.sessionVariables = config.home.sessionVariables;
}
