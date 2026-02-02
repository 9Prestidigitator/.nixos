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
      bar = {
        capsuleOpacity = lib.mkForce 1;
        density = "comfortable";
        barType = "floating";
        floating = true;
        marginVertical = 8;
        marginHorizontal = 8;
        position =
          if isLaptop
          then "left"
          else "bottom";
        displayMode = "auto_hide";
        autoHideDelay = 500;
        autoShowDelay = 150;
        showCapsule = false;
        showOutline = false;
        outerCorners = false;
        useSeparateOpacity = false;
        backgroundOpacity = lib.mkForce 0;
        widgets = {
          left =
            []
            ++ lib.optional isLaptop {
              id = "ControlCenter";
              colorizeDistroLogo = false;
              customIconPath = "";
              icon = "";
              useDistroLogo = true;
            }
            ++ [
              {
                id = "TaskbarGrouped";
                characterCount = 2;
                colorizeIcons = false;
                hideUnoccupied = true;
                labelMode = "index";
                showNumbersOnlyWhenOccupied = true;
                showWorkspaceNumbers = false;
                iconScale = 0.85;
                groupedBorderOpacity = 0.5;
                unfocusedIconsOpacity = 0.9;
              }
              {
                id = "plugin:catwalk";
              }
            ];
          center =
            []
            ++ lib.optional (!isLaptop) {
              id = "ControlCenter";
              colorizeDistroLogo = false;
              customIconPath = "";
              icon = "";
              useDistroLogo = true;
            };
          right = [
            {
              blacklist = [];
              colorizeIcons = false;
              drawerEnabled = true;
              id = "Tray";
              pinned = [];
            }
            {
              id = "NotificationHistory";
              hideWhenZero = true;
              showUnreadBadge = true;
            }
            {
              id = "Bluetooth";
              displayMode = "onhover";
            }
            {
              id = "Volume";
              displayMode = "onhover";
            }
            {
              id = "Network";
              displayMode = "onhover";
            }
            {
              id = "Battery";
              hideIfNotDetected = true;
              deviceNativePath = "BAT0";
              showNoctaliaPerformance = true;
              showPowerProfiles = true;
              warningThreshold = 25;
              displayMode = "onhover";
            }
            {
              customFont = "";
              formatHorizontal = "HH:mm:ss - MM dd yy";
              formatVertical = "ss mm HH - dd MM yy";
              tooltipFormat = "HH:mm - ddd, MMM dd yyyy";
              id = "Clock";
              useCustomFont = false;
              usePrimaryColor = true;
            }
          ];
        };
      };
    };
  };
}
