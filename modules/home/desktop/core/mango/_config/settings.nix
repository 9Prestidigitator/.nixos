{
  config,
  lib,
  ...
}: let
  stylixColors = lib.attrByPath ["lib" "stylix" "colors"] null config;
  color = hex: alpha: "0x${hex}${alpha}";
in {
  wayland.windowManager.mango.settings =
    {
      blur = 1;
      blur_layer = 1;
      blur_optimized = 0;
      blur_params = {
        radius = 5;
        num_passes = 3;
        noise = 0.02;
      };

      shadows = 1;
      layer_shadows = 0;
      shadow_only_floating = 1;
      shadows_position_x = 0;
      shadows_position_y = 0;

      gap_inner_horizontal = 4;
      gap_inner_vertical = 4;
      gap_outer_horizontal = 4;
      gap_outer_vertical = 4;
      border_px = 2;
      border_radius = 8;
      no_border_when_single = 1;
      no_radius_when_single = 1;
      smart_gaps = 1;

      focus_on_activate = 1;
      sloppy_focus = 0;
      warp_cursor = 1;
      new_is_master = 0;
      axis_bind_apply_timeout = 100;
      drag_tile_to_tile = 1;
      enable_floating_snap = 0;
      snap_distance = 30;
      enable_hotarea = 1;
      hotarea_corner = 0;

      tap_to_click = 1;
      trackpad_natural_scrolling = 1;
      mouse_accel_speed = -0.3;

      device_rule = [
        "name:SteelSeries SteelSeries Aerox 3 Keyboard,accel_profile:0"
      ];

      tag_rule = [
        "id:*,layout_name:scroller"

        # "id:1,layout_name:monocle"
        # "id:2,layout_name:scroller"
        # "id:3,layout_name:vertical_scroller"

        # "id:1,no_hide:1,layout_name:scroller,scroller_default_proportion:0.8"
        # "id:2,no_hide:1,layout_name:tile,nmaster:1,mfact:0.55"
        # "id:3,no_hide:1,layout_name:grid"
        # "id:4,no_hide:1,layout_name:monocle,no_render_border:1"
        # "id:5,layout_name:deck"
        # "id:6,layout_name:center_tile"
        # "id:7,layout_name:dwindle"
        # "id:8,layout_name:vertical_scroller"
        # "id:9,layout_name:vertical_tile"
      ];

      circle_layout = "scroller,monocle,tile,vertical_scroller";

      scroller_default_proportion = 1;
      scroller_proportion_preset = "0.5,0.8,1.0";
      scroller_structs = 0;
      default_master_factor = 0.55;
      default_master_count = 1;
      center_master_overspread = 1;

      animations = 1;
      layer_animations = 1;
      animation_type_open = "slide";
      animation_type_close = "fade";
      animation_duration = {
        move = 250;
        open = 250;
        tag = 250;
        close = 200;
      };
      tag_animation_direction = 0;

      scratchpad_width_ratio = 0.8;
      scratchpad_height_ratio = 0.8;
      scratchpad_cross_monitor = 1;
    }
    // lib.optionalAttrs (stylixColors != null) {
      root_color = color stylixColors.base00 "ff";
      border_color = color stylixColors.base03 "00";
      drop_color = color stylixColors.base0B "55";
      split_color = color stylixColors.base08 "ff";
      focus_color = color stylixColors.base0D "ff";
      maximized_screen_color = color stylixColors.base0B "ff";
      urgent_color = color stylixColors.base08 "ff";
      scratchpad_color = color stylixColors.base0E "ff";
      global_color = color stylixColors.base0C "ff";
      overlay_color = color stylixColors.base0D "ff";
      shadows_color = color stylixColors.base00 "a0";
    };
}
