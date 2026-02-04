{
  pkgs,
  lib,
  inputs,
  config,
  ...
}: {
  config = lib.mkIf config.desktop.design.enable {
    environment.systemPackages = with pkgs; [
      inkscape-with-extensions
      gimp-with-plugins
      krita
      krita-plugin-gmic
      blender
      davinci-resolve
      kdePackages.kdenlive
      libreoffice-qt
      hunspell
    ];
  };
}
