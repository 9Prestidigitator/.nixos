{
  lib,
  config,
  inputs,
  pkgs,
  osConfig,
  ...
}: let
  cfg = osConfig.desktop;
  isNiri = cfg.enable && cfg.mode == "niri";
  isHyprland = cfg.enable && cfg.mode == "hyprland";
in {
  config = lib.mkIf (osConfig.services.noctalia-shell.enable or false) {
    programs.noctalia-shell = {
      settings = {
        dock = {
          pinnedApps =
            [
              "kitty"
              "org.gnome.Nautilus"
              "brave-browser"
            ]
            ++ lib.optionals osConfig.desktop.gaming.enable [
              "steam"
            ]
            ++ lib.optionals osConfig.desktop.comms.enable [
              "discord"
            ]
            ++ lib.optionals osConfig.desktop.musicprod.enable [
              "com.bitwig.BitwigStudio"
            ];
        };
      };
    };
  };
}
