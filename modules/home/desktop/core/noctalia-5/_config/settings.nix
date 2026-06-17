{
  programs.noctalia.settings = {
    shell = {
      launch_apps_as_systemd_services = true;

      niri_overview_type_to_launch_enabled = false;
      polkit_agent = true;

      font_family = "Noto Sans";
      animation.speed = 1.50;

      panel = {
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

    dock = {
      enabled = true;
      auto_hide = true;
      background_opacity = 0;
      icon_size = 30;
      item_spacing = 0;
      show_dots = true;

      magnification_scale = 1.3;
      radius = 30;
      padding = 4;
      margin_edge = 7;

      launcher_icon = "brand-snowflake";
      launcher_position = "start";

      pinned = [
        "files"
        "Brave Web Browser"
      ];
    };

    lockscreen = {
      blur_intensity = 0.7;
      blurred_desktop = true;
    };
  };
}
