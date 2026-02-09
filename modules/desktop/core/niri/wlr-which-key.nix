{
  config,
  lib,
  pkgs,
  ...
}: menu: let
  configFile =
    pkgs.writeText "config.yaml"
    (lib.generators.toYAML {} {
      anchor = "bottom-right";
      # ...
      inherit menu;
    });
in
  pkgs.writeShellScriptBin "my-menu" ''
    exec ${lib.getExe pkgs.wlr-which-key} ${configFile}
  ''
