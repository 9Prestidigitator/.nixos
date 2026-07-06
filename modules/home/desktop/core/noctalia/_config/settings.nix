{
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

      niri_overview_type_to_launch_enabled = false;
      screen_time_enabled = true;
      polkit_agent = true;

      # font_family = "Noto Sans";
      animation.speed = 1.50;
      avatar_path = "${config.xdg.userDirs.pictures}/.face";

      panel = {
        open_near_click_control_center = true;
        clipboard_placement = "attached";
        launcher_compact = true;
        open_near_click_launcher = true;
        session_placement = "centered";
        transparency_mode = "glass";
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

    dock = {
      enabled = true;
      auto_hide = true;
      icon_size = 35;
      item_spacing = 0;
      show_dots = true;

      magnification_scale = 1.3;
      radius = 30;
      padding = 4;
      margin_edge = 7;
      reserve_space = false;

      launcher_icon = "grid-dots";
      launcher_position = "start";

      pinned = [
        "kitty"
        "files"
        "Brave Web Browser"
        "Bitwig Studio"
        "REAPER"
      ];
    };

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
      position = "bottom_right";
    };

    osd = {
      orientation = "horizontal";
      position = "bottom_center";
      # background_opacity = 0.4;
    };

    # theme = {
    #   source = "community";
    #   community_palette = "GitHub Dark";
    # };

    wallpaper.transition_on_startup = true;

    brightness.enable_ddcutil = true;
  };
}
