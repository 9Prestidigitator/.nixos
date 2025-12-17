{
  lib,
  config,
  inputs,
  pkgs,
  osConfig,
  ...
}: {
  imports = [
    inputs.noctalia.homeModules.default
  ];

  programs.noctalia-shell = {
    settings = {
      dock = {
        pinnedApps =
          [
            "kitty"
            "org.gnome.Nautilus"
            "brave-browser"
          ]
          ++ lib.optionals config.desktop.gaming.enable [
            "steam"
          ]
          ++ lib.optionals config.desktop.comms.enable [
            "discord"
          ]
          ++ lib.optionals config.desktop.musicprod.enable [
            "com.bitwig.BitwigStudio"
          ];
      };
    };
  };
}
