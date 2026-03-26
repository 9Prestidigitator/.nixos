{inputs, ...}: {
  flake.nixosModules.stylix = {pkgs, config, ... }: {
    imports = [inputs.stylix.nixosModules.stylix];
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
      targets.grub.enable = false;
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
      opacity = {
        desktop = 0.85;
        terminal = 0.85;
      };
    };
  };

  flake.homeModules.general = {pkgs, ...}: {
    stylix = {
      gtk.enable = true;
      qt.enable = true;
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
  };
}
