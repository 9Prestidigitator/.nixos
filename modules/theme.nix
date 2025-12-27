{
  pkgs,
  lib,
  inputs,
  config,
  ...
}: {
  imports = [
    inputs.stylix.nixosModules.stylix
  ];
  stylix = {
    enable = true;
    autoEnable = true;
    base16Scheme =
      if config.networking.hostName == "ink"
      then "${pkgs.base16-schemes}/share/themes/da-one-black.yaml"
      else if config.networking.hostName == "papyr"
      then "${pkgs.base16-schemes}/share/themes/ayu-dark.yaml"
      else "${pkgs.base16-schemes}/share/themes/ayu-dark.yaml";

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
    targets.grub.enable = false;
  };
  home-manager.sharedModules = [
    {
      stylix = {
        iconTheme = {
          enable = true;
          package = pkgs.kdePackages.breeze;
          dark = "breeze-dark";
          light = "breeze";
        };
        targets = {
          spicetify.enable = false;
          neovim.enable = false;
        };
      };
    }
  ];
}
