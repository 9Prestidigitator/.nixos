{
  lib,
  config,
  inputs,
  pkgs,
  osConfig,
  ...
}: let
  cfg = osConfig.desktop;
  isNiri = cfg.enable && cfg.wayCompositor == "niri";
  isLaptop = osConfig.networking.hostName != "ink";
in {
  programs.noctalia-shell = {
    settings = {
      bar = {
        capsuleOpacity = lib.mkForce 1;
        density = "default";
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
              colorizeDistroLogo = false;
              customIconPath = "";
              icon = "";
              id = "ControlCenter";
              useDistroLogo = true;
            }
            {
              characterCount = 2;
              colorizeIcons = false;
              hideUnoccupied = true;
              id = "TaskbarGrouped";
              labelMode = "index";
              showNumbersOnlyWhenOccupied = true;
              showWorkspaceNumbers = false;
              iconScale = 0.85;
              groupedBorderOpacity = 0.5;
              unfocusedIconsOpacity = 0.9;
            }
            {
              id = "plugins:catwalk";
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
            ++ lib.optional isLaptop {
              displayMode = "onhover";
              id = "Brightness";
            }
            ++ [
              {
                hideWhenZero = true;
                id = "NotificationHistory";
                showUnreadBadge = true;
              }
              {
                displayMode = "onhover";
                id = "Bluetooth";
              }
              {
                displayMode = "onhover";
                id = "Volume";
              }
              {
                displayMode = "onhover";
                id = "WiFi";
              }
            ]
            ++ lib.optional isLaptop {
              displayMode = "onhover";
              id = "Battery";
              warningThreshold = 30;
            }
            ++ [
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
