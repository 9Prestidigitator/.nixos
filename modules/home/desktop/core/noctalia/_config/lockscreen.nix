{
  pkgs,
  osConfig,
  ...
}: let
  isLaptop =
    if osConfig.networking.hostName == "ink"
    then false
    else true;

  primaryMonitor =
    if osConfig.networking.hostName == "book"
    then rec {
      name = "eDP-1";
      width = 1366;
      height = 768;
      scale = 1.1;
      logicalWidth = width / scale;
      logicalHeight = height / scale;
    }
    else if isLaptop
    then rec {
      name = "eDP-1";
      width = 1920;
      height = 1080;
      scale = 1.3;
      logicalWidth = width / scale;
      logicalHeight = height / scale;
    }
    else rec {
      name = "DP-1";
      width = 1920;
      height = 1080;
      scale = 1.0;
      logicalWidth = width / scale;
      logicalHeight = height / scale;
    };
in {
  programs.noctalia.settings = {
    lockscreen = {
      blur_intensity = 1;
      blurred_desktop = true;
    };

    lockscreen_widgets = {
      enabled = true;
      widget_order = [
        "lockscreen-widget-0000000000000003"
        "lockscreen-widget-0000000000000002"
        "lockscreen-widget-0000000000000001"
        "lockscreen-login-box@${primaryMonitor.name}"
      ];

      grid = {
        cell_size = 16;
        major_interval = 4;
        visible = true;
      };

      widget = {
        "lockscreen-login-box@${primaryMonitor.name}" = {
          box_height = 65;
          box_width = 300;
          cx = primaryMonitor.logicalWidth / 2;
          cy = primaryMonitor.logicalHeight / 3 * 2;
          output = primaryMonitor.name;
          rotation = 0;
          type = "login_box";
          settings = {
            background_color = "surface_variant";
            background_opacity = 0;
            background_radius = 35;
            input_opacity = 0.5;
            input_radius = 30;
            show_login_button = true;
          };
        };

        lockscreen-widget-0000000000000001 = {
          box_height = 220.0;
          box_width = 350.0;
          cx = primaryMonitor.logicalWidth / 2;
          cy = primaryMonitor.logicalHeight / 3;
          output = primaryMonitor.name;
          rotation = 0.0;
          type = "clock";
          settings = {
            background = false;
            clock_style = "digital";
            color = "primary";
          };
        };

        lockscreen-widget-0000000000000002 = {
          box_height = 240;
          box_width = 480;
          cx = primaryMonitor.logicalWidth / 2;
          cy = primaryMonitor.logicalHeight / 3;
          output = primaryMonitor.name;
          rotation = 0.0;
          type = "audio_visualizer";
          settings = {
            aspect_ratio = 2.4;
            background = false;
            bands = 36.0;
            mirrored = false;
            show_when_idle = false;
            color_1 = "secondary";
            color_2 = "tertiary";
          };
        };

        lockscreen-widget-0000000000000003 = {
          box_height = 240.0;
          box_width = 240.0;
          cx = primaryMonitor.logicalWidth / 2;
          cy = primaryMonitor.logicalHeight / 3;
          output = primaryMonitor.name;
          rotation = 0.0;
          type = "sticker";
          settings = {
            background = false;
            image_path = "${pkgs.nixos-icons}/share/icons/hicolor/256x256/apps/nix-snowflake-white.png";
            opacity = 1.0;
          };
        };

        lockscreen-widget-0000000000000004 = {
          box_height = 64;
          box_width = 160;
          cx = primaryMonitor.logicalWidth / 2;
          cy = primaryMonitor.logicalHeight * 0.55;
          output = primaryMonitor.name;
          rotation = 0.0;
          type = "media_player";
          settings = {
            background = false;
            hide_when_no_media = true;
            layout = "horizontal";
          };
        };
      };
    };
  };
}
