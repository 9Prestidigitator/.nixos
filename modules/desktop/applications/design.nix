{
  pkgs,
  lib,
  inputs,
  config,
  ...
}: {
  config = lib.mkIf config.design.enable {
    environment.systemPackages = with pkgs; [
      inkscape-with-extensions
      gimp-with-plugins
      blender
      davinci-resolve
    ];
  };
}
