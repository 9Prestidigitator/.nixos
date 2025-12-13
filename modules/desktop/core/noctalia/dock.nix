{
  lib,
  config,
  inputs,
  pkgs,
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
        pinnedApps = [
          "kitty"
          "org.gnome.Nautilus"
          "brave-browser"
          "steam"
          "discord"
          "com.bitwig.BitwigStudio"
        ];
        pinnedStatic = true;
        size = 1;
      };
    };
  };
}
