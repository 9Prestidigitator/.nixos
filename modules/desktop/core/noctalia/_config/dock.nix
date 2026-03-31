{lib, ...}: {
  programs.noctalia-shell = {
    settings = {
      dock = {
        enabled = true;
        position = "bottom";
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
        groupApps = true;
        groupContextMenuMode = "extended";
        groupClickAction = "cycle";
        groupIndicatorStyle = "dots";
        showLauncherIcon = true;
        launcherUseDistroLogo = true;
        launcherPosition = "start";
        launcherIconColor = "none";
        pinnedApps = [
          "kitty"
          "org.gnome.Nautilus"
          "brave-browser"
          "steam"
          "com.bitwig.BitwigStudio"
        ];
        # ++ lib.optionals osConfig.desktop.gaming.enable [
        #   "steam"
        # ]
        # ++ lib.optionals osConfig.desktop.musicprod.enable [
        #   "com.bitwig.BitwigStudio"
        # ];
      };
    };
  };
}
