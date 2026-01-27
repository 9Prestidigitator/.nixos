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
      controlCenter = {
        position = "close_to_bar_button";
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
        shortcuts = {
          left = [
            {
              id = "plugin:timer";
            }
            {
              id = "plugin:screen-recorder";
            }
            {
              id = "WallpaperSelector";
            }
          ];
          right = [
            {
              id = "CustomButton";
              enableOnStateLogic = false;
              generalTooltipText = "keybinds";
              icon = "keyboard";
              onClicked = "noctalia-shell ipc call plugin:keybind-beta toggle";
            }
            {
              id = "NightLight";
            }
            {
              id = "KeepAwake";
            }
          ];
        };
      };
    };
  };
}
