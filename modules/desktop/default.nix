{
  lib,
  config,
  inputs,
  pkgs,
  ...
}: {
  config = lib.mkIf config.desktop.enable {
    fonts.packages = with pkgs; [
      corefonts
      vista-fonts
      material-design-icons
      fira
      fira-sans
      roboto

      noto-fonts
      noto-fonts-color-emoji

      nerd-fonts.symbols-only
      nerd-fonts.hack
      nerd-fonts.jetbrains-mono
      nerd-fonts.fira-code
      nerd-fonts.iosevka
    ];

    home-manager.sharedModules = [
      {
        xdg = {
          userDirs = {
            enable = true;
            createDirectories = true;
          };
          terminal-exec = {
            enable = true;
            settings.default = ["kitty.desktop"];
          };
        };
      }
    ];
  };
}
