{
  flake.nixosModules.design = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      inkscape-with-extensions
      gimp-with-plugins
      krita
      krita-plugin-gmic
      libreoffice-qt
      hunspell
    ];
  };
}
