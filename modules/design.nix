{
  pkgs,
  lib,
  inputs,
  config,
  ...
}: {
  options = {
    design.enable = lib.mkEnableOption "Enable extra creative disktop applications.";
  };

  config = lib.mkIf config.design.enable {
    environment.systemPackages = with pkgs; [
      inkscape-with-extensions
      gimp-with-plugins
      blender
    ];
  };
}
