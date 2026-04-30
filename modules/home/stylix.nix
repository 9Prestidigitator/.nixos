{
  flake.homeModules.stylix = {pkgs, ...}: {
    stylix = {
      targets = {
        spicetify.enable = false;
        neovim.enable = false;
      };
      icons = {
        enable = true;
        package = pkgs.kdePackages.breeze;
        dark = "breeze-dark";
        light = "breeze";
      };
    };
  };
}
