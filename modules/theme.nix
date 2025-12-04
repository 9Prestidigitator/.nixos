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
    autoEnable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/chalk.yaml";
    polarity = "dark";
    cursor = {
      size = 24;
      name = "breeze_cursors";
      package = pkgs.kdePackages.breeze;
    };
    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.hack;
        name = "Hack Nerd Font Mono";
      };
    };
  };
  home-manager.users.${username} = {
    stylix = {
      iconTheme = {
        enable = true;
        package = pkgs.kdePackages.breeze;
        dark = "breeze-dark";
        light = "breeze";
      };
      targets = {
        kitty.enable = false;
        spicetify.enable = false;
        neovim.enable = false;
      };
    };
  };
}
