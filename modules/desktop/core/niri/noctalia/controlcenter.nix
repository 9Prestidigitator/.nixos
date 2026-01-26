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
      controlCenter = {
        cards = [
          {
            enabled = true;
            id = "profile-card";
          }
          {
            enabled = true;
            id = "shortcuts-card";
          }
          {
            enabled = true;
            id = "audio-card";
          }
          {
            enabled = false;
            id = "weather-card";
          }
          {
            enabled = true;
            id = "media-sysmon-card";
          }
          {
            enabled =
              if isLaptop
              then true
              else false;
            id = "brightness-card";
          }
        ];
        position = "close_to_bar_button";
        shortcuts = {
          left = [
            {
              id = "plugin:timer";
            }
            {
              id = "plugin:screen-recorder";
            }
            {
              id = "CustomButton";
              enableOnStateLogic = false;
              generalTooltipText = "keybinds";
              icon = "keyboard";
              onClicked = "noctalia-shell ipc call plugin:keybind-beta toggle";
            }
            {
              id = "WallpaperSelector";
            }
          ];
          right = [
            {
              id = "KeepAwake";
            }
            {
              id = "PowerProfile";
            }
            {
              id = "NightLight";
            }
            {
              id = "NoctaliaPerformance";
            }
          ];
        };
      };
    };
  };
}
