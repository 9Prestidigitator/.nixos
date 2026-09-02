{
  programs.umbriel = {
    settings = {
      general = {
        xwayland = true;
        show_cheatsheet = true;
        focus_on_activate = false;
        honor_restored_maximize = true;
      };
      layout = {
        gap = 8;
        mode = "scrolling";
        width_presets = [0.333 0.5 0.667];
        struts = {
          left = 0;
          right = 0;
          top = 0;
          bottom = 0;
        };
        scrolling = {
          direction = "horizontal";
          default_width_fraction = 0.5; # remove to let clients choose their initial width
          center_underfull_strip = true; # center the strip whenever it is narrower than the viewport
          center_focused = false; # always center the focused column
          expand_single_column = true; # fill lone column to viewport width
        };
        dwindle = {
          preserve_split = false;
        };
        master = {
          position = "left"; # "left" or "right"
          default_width_fraction = 0.55; # 0.1-0.9
          new_on_top = true; # place new windows at the top of the stack
        };
      };
      input = {
        middle_click_paste = false;
        keyboard.numlock_toggle = true;
        touchpad = {
          tap = true;
          natural_scroll = true;
        };
        mouse = {
          accel_profile = "flat"; # disables speed-dependent acceleration
          sensitivity = 0.0; # pointer speed, -1.0 to 1.0
          scroll_wheel_step = 60; # 1-1000
        };
        tablet.enabled = true;
        cursor = {
          hardware_cursor = true; # false forces software cursor composition
          follows_focus = false; # warp to windows selected by focus navigation
          hide_timeout_ms = 0; # 0-3600000, 0 disables hiding
        };
        focus.follows_mouse = false;
      };
      appearance = {
        prefer_no_csd = true;
        border_width = 2; # 0-100
        outer_border_width = 0; # 0-100
        corner_radius = 10; # 0-100, radius of the final decorated outer edge
        drag_opacity = 0.75;
        blur = {
          enabled = true;
          optimized = true;
          passes = 3;
          radius = 5;
          noise = 0.02;
          brightness = 0.9;
          contrast = 0.9;
          saturation = 1.1;
        };
        shadow = {
          enabled = true;
          softness = 10; # 0-200, 0 = hard edge
          offset_x = 2; # -200 to 200
          offset_y = 2;
          color = "#0000007F";
        };
      };
      workspaces = {
        back_and_forth = false;
        empty_above = false;
      };
      overview = {
        zoom = 0.4;
        background_blur = true;
      };
      hot_corners = {
        top_left = {
          enabled = true;
          delay_ms = 500; # 0-10000, 0 activates immediately
          action = "overview-open";
        };
        top_right = {
          enabled = false;
          delay_ms = 500;
          action = "overview-close";
        };
        bottom_left = {
          enabled = false;
          delay_ms = 500;
          action = "overview-toggle";
        };
        bottom_right = {
          enabled = false;
          delay_ms = 500;
          action = "spawn:notify-send 'Bottom right'";
        };
      };
      animation = {
        enabled = true;
        duration_ms = 250;
        curve = "easeout";
        windows_in = {
          enabled = true;
          duration_ms = 150;
          curve = "easeout";
          style = "popin"; # popin, zoom, slide, fade, none
          scale = 0.85; # 0.1-1.0, used by popin
        };
        windows_out = {
          enabled = true;
          duration_ms = 150;
          curve = "easeout";
          style = "fade"; # fade, slide
        };
        windows_move = {
          enabled = true;
          duration_ms = 250;
          curve = "snappy";
        };
        workspaces = {
          enabled = true;
          duration_ms = 250;
          curve = "easeout";
        };
        overview = {
          enabled = true;
          duration_ms = 250;
          curve = "easeout";
        };
        scratchpad = {
          enabled = false;
          duration_ms = 250;
          curve = "easeout";
          dim = 0.5; # 0.0-1.0
          blur = false;
          scale = 0.0; # 0 preserves the window geometry
          maximize = false;
          fullscreen = false;
        };
        border = {
          enabled = false;
          duration_ms = 250;
          curve = "easeout";
        };
        dim_unfocused = {
          enabled = false;
          duration_ms = 250;
          curve = "easeout";
          dim = 0.0; # 0.0-1.0
        };
        layers = {
          enabled = false;
          duration_ms = 250;
          curve = "easeout";
        };
      };
    };
  };
}
