{
  lib,
  config,
  inputs,
  pkgs,
  osConfig,
  ...
}: let
  cfg = config.desktop;
  isNiri = cfg.enable && cfg.mode == "niri";
in {
  programs.noctalia-shell = {
    settings = {
      bar = {
        density = "comfortable";
        transparent = false;
        floating = false;
        # marginHorizontal = 1.36;
        # marginVertical = 0;
        outerCorners = false;
        position =
          if isNiri
          then "left"
          else "top";
        showCapsule = false;
        showOutline = false;
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
              labelMode = "none";
              showNumbersOnlyWhenOccupied = true;
              showWorkspaceNumbers = false;
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
            ++ lib.optional (osConfig.networking.hostName != "ink") {
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
            ++ lib.optional (osConfig.networking.hostName != "ink") {
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
