{
  flake.homeModules.stylix = {
    lib,
    pkgs,
    ...
  }: {
    stylix = {
      targets = {
        wayprompt.enable = false;
        spicetify.enable = false;
        neovim.enable = false;
        # Might explore more interesting kde ricing later
        # kde.enable = false;
      };
    };

    gtk.iconTheme = lib.mkForce {
      package = pkgs.adwaita-icon-theme;
      name = "Adwaita";
    };
  };
}
