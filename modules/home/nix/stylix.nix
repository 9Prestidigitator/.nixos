{
  flake.homeModules.stylix = {
    lib,
    pkgs,
    ...
  }: {
    stylix = {
      targets = {
        spicetify.enable = false;
        neovim.enable = false;
        kde.enable = false;
      };
    };

    gtk.iconTheme = lib.mkForce {
      package = pkgs.adwaita-icon-theme;
      name = "Adwaita";
    };
  };
}
