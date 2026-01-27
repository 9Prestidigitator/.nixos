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
              id = "CustomButton";
              enableOnStateLogic = false;
              generalTooltipText = "Niri Launcher/Keybinds";
              icon = "niri";
              onClicked = "noctalia-shell ipc call launcher toggle";
              onRightClicked = "noctalia-shell ipc call plugin:keybind-cheatsheet toggle";
            }
            {
              id = "plugin:timer";
            }
            {
              id = "WallpaperSelector";
            }
          ];
          right = [
            {
              id = "NightLight";
            }
            {
              id = "plugin:screen-recorder";
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
