{
  lib,
  config,
  inputs,
  pkgs,
  osConfig,
  ...
}: {
  programs.noctalia-shell = {
    settings = {
      dock = {
        enabled = true;
        backgroundOpacity = lib.mkForce 0;
        colorizeIcons = false;
        displayMode = "auto_hide";
        floatingRatio = 0.58;
        inactiveIndicators = true;
        deadOpacity = 0.4;
        monitors = [];
        onlySameOutput = false;
        pinnedStatic = true;
        size = 1;
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
}
