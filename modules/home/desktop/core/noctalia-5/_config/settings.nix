{
  lib,
  config,
  ...
}: {
  programs.noctalia.settings = {
    shell = {
      font_family = "Noto Sans";

      niri_overview_type_to_launch_enabled = true;
      polkit_agent = true;

      animation.speed = 1.10;

      panel = {
        clipboard_placement = "attached";
        launcher_compact = true;
        open_near_click_launcher = true;
        session_placement = "centered";
        transparency_mode = "glass";
      };

      shadow.direction = "center";
    };

    nightlight.enabled = true;

    dock = {
      enabled = true;
      auto_hide = true;
      background_opacity = 0.0;
      icon_size = 30;
      item_spacing = 0;

      magnification_scale = 1.3;
      show_dots = true;
      padding = 4;

      launcher_icon = "brand-snowflake";
      launcher_position = "start";
      pinned = ["files" "Brave Web Browser"];
      radius = 30;
      margin_edge = 7;
    };
  };
}
