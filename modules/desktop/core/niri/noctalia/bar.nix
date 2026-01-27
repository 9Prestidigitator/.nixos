{
  lib,
  config,
  inputs,
  pkgs,
  osConfig,
  isLaptop,
  ...
}: let
  cfg = osConfig.desktop;
  isNiri = cfg.enable && cfg.wayCompositor == "niri";
in {
  programs.noctalia-shell = {
    settings = {
      bar = {
        capsuleOpacity = lib.mkForce 1;
        density = "comfortable";
        exclusive = true;
        floating = false;
        marginHorizontal = 1.36;
        marginVertical = 0;
        monitors = [];
        outerCorners = false;
        position =
          if isNiri
          then "left"
          else "top";
        showCapsule = false;
        showOutline = false;
        useSeparateOpacity = false;
        backgroundOpacity = lib.mkForce 0;
        widgets = {
          center = [];
          left = [
            {
              id = "ControlCenter";
              colorizeDistroLogo = false;
              customIconPath = "";
              icon = "";
              useDistroLogo = true;
            }
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
          right =
            [
              {
                blacklist = [];
                colorizeIcons = false;
                drawerEnabled = true;
                id = "Tray";
                pinned = [];
              }
            ]
            ++ lib.optional isLaptop {
              displayMode = "onhover";
              id = "VPN";
            }
            ++ [
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
                formatHorizontal = "HH:mm ddd; MMM dd";
                formatVertical = "ss mm HH - dd MM yy";
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
