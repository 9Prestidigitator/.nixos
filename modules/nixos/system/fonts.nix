{
  flake.nixosModules.fonts = {pkgs, ...}: {
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
  };
}
