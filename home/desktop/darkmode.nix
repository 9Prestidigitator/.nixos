{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    qt_gtk_dark_default.enable = lib.mkEnableOption "Enables music production configuration.";
  };

  config = lib.mkIf config.qt_gtk_dark_default.enable {
    gtk = {
      enable = true;
      theme = {
        name = "Adwaita-dark";
        package = pkgs.adwaita-icon-theme;
      };
      iconTheme = {
        name = "Adwaita";
        package = pkgs.adwaita-icon-theme;
      };
    };
    qt = {
      enable = true;
      platformTheme.name = "adwaita";
      style = {
        name = "adwaita-dark";
        package = pkgs.adwaita-qt;
      };
    };
    dconf.settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
        gtk-theme = "Adwaita-dark";
      };
      "org/gnome/desktop/background" = {
        picture-uri = "file://${pkgs.nixos-artwork.wallpapers.nineish-dark-gray.src}";
        picture-uri-dark = "file://${pkgs.nixos-artwork.wallpapers.nineish-dark-gray.src}";
      };
    };
    home.sessionVariables = {
      GTK_THEME = "Adwaita-dark";
      QT_STYLE_OVERRIDE = "adwaita-dark";
    };
    systemd.user.sessionVariables = config.home.sessionVariables;
  };
}
