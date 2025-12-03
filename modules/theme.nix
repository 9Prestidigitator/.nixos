{
  pkgs,
  lib,
  inputs,
  config,
  username,
  ...
}: {
  imports = [
    inputs.stylix.nixosModules.stylix
  ];
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/everforest-dark-hard.yaml";
    polarity = "dark";
    cursor = {
      size = 8;
      name = "graphite-dark";
      package = pkgs.graphite-cursors;
    };
    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.hard;
        name = "Hack Nerd Font Mono";
      };
    };
  };
  home-manager.users.${username} = {
    stylix = {
      iconTheme = {
        enable = true;
        package = pkgs.numix-icon-theme-circle;
        dark = "Numix-Circle";
        light = "Numix-Circle-Light";
      };
      targets = {
        kitty.enable = false;
        spicetify.enable = false;
      };
    };
  };
}
