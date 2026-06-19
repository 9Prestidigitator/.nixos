{pkgs, ...}: {
  programs.noctalia.settings = {
    lockscreen = {
      blur_intensity = 0.7;
      blurred_desktop = true;
    };

    lockscreen_widgets = {
      enabled = true;
      widget_order = [
        "lockscreen-widget-0000000000000003"
        "lockscreen-widget-0000000000000002"
        "lockscreen-widget-0000000000000001"
      ];

      grid = {
        cell_size = 16;
        major_interval = 4;
        visible = true;
      };

      widget = {
        lockscreen-widget-0000000000000001 = {
          box_height = 208.0;
          box_width = 304.0;
          cx = 621.0;
          cy = 181.0;
          # output = "eDP-1";
          rotation = 0.0;
          type = "clock";
          settings = {
            background = false;
            clock_style = "digital";
            color = "primary";
          };
        };

        lockscreen-widget-0000000000000002 = {
          box_height = 240.0;
          box_width = 480.0;
          cx = 621.0;
          cy = 181.0;
          # output = "eDP-1";
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
          cx = 621.0;
          cy = 181.0;
          # output = "eDP-1";
          rotation = 0.0;
          type = "sticker";
          settings = {
            background = false;
            image_path = "${pkgs.nixos-icons}/share/icons/hicolor/256x256/apps/nix-snowflake-white.png";
            opacity = 1.0;
          };
        };
      };
    };
  };
}
