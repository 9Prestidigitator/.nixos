{
  lib,
  config,
  inputs,
  pkgs,
  osConfig,
  isLaptop,
  ...
}: {
  programs.noctalia-shell = {
    settings = {
      dock = {
        enabled = true;
        # if isLaptop
        # then true
        # else false;
        position = "top";
        # if isLaptop
        # then "bottom"
        # else "left";
        backgroundOpacity = lib.mkForce 0.15;
        floatingRatio = 0.4;
        size = 0.9;
        colorizeIcons = false;
        displayMode = "auto_hide";
        inactiveIndicators = true;
        deadOpacity = 0.4;
        monitors = [];
        onlySameOutput = false;
        pinnedStatic = true;
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
