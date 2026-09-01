{
  lib,
  config,
  osConfig,
  ...
}: let
  isLaptop =
    if osConfig.networking.hostName == "ink"
    then false
    else true;
in {
  programs.noctalia.settings = {
    shell = {
      launch_apps_as_systemd_services = true;

      screen_time_enabled = true;
      polkit_agent = true;
      popup_shadows = lib.mkDefault false;

      # font_family = "Noto Sans";
      animation.speed = 1.50;
      avatar_path = "${config.xdg.userDirs.pictures}/.face";

      panel = {
        open_near_click_control_center = true;
        clipboard_placement = "attached";
        launcher_compact = true;
        open_near_click_launcher = true;
        session_placement = "centered";
        transparency_mode = lib.mkDefault "glass";
      };

      shadow.direction = "center";
    };

    control_center = {
      compact = false;
      width = 750;
      shortcuts = [
        {type = "wifi";}
        {type = "caffeine";}
        {type = "notification";}
        {type = "clipboard";}
        {type = "noctalia/screen_recorder:toggle";}
        {type = "power_profile";}
      ];
    };

    nightlight.enabled = true;
    calendar.enabled = true;
    weather.auto_locate = true;
    location.auto_locate = true;

    idle = {
      behavior_order = ["lock" "screen-off" "suspend"];
      behavior = {
        lock = {
          enabled = true;
          action = "lock";
          timeout = 600;
        };
        screen-off = {
          enabled = true;
          action = "screen_off";
          timeout = 660;
        };
        lock-and-suspend = {
          enabled = isLaptop;
          action = "lock_and_suspend";
          timeout = 900;
        };
      };
    };

    notification = {
      layer = "overlay";
      position = "top_right";
      offset_x = 30;
      offset_y = 40;
    };

    osd = {
      orientation = "horizontal";
      position = "bottom_center";
      # background_opacity = 0.4;
    };

    theme.templates = {
      enable_builtin_templates = false;
      enable_community_templates = false;
    };

    wallpaper = {
      directory = "${config.home.homeDirectory}/Pictures/Wallpapers";
      transition_on_startup = true;
    };

    brightness.enable_ddcutil = true;
  };
}
