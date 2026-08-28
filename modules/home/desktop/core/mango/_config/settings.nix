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
      blur_layer = 0;
      blur_optimized = 1;
      blur_params = {
        radius = 5;
        num_passes = 3;
        noise = 0.02;
      };

      shadows = 1;
      layer_shadows = 0;
      shadows_only_floating = 1;
      shadows_position_x = 0;
      shadows_position_y = 0;

      border_radius = 5;
      no_radius_when_single = 0;

      gappih = 10;
      gappiv = 10;
      gappoh = 5;
      gappov = 5;
      borderpx = 2;

      sloppyfocus = 0;
      warpcursor = 1;

      tap_to_click = 1;
      trackpad_natural_scrolling = 1;

      tagrule = [
        "id:1,no_hide:1,layout_name:scroller,scroller_default_proportion:0.8"
        "id:2,no_hide:1,layout_name:tile,nmaster:1,mfact:0.55"
        "id:3,no_hide:1,layout_name:grid"
        "id:4,no_hide:1,layout_name:monocle,no_render_border:1"
        "id:5,layout_name:deck"
        "id:6,layout_name:center_tile"
        "id:7,layout_name:dwindle"
        "id:8,layout_name:vertical_scroller"
        "id:9,layout_name:vertical_tile"
      ];

      scroller_default_proportion = 0.8;
      scroller_proportion_preset = "0.5,0.8,1.0";
      default_mfact = 0.55;
      default_nmaster = 1;

      animations = 1;
      layer_animations = 1;
      animation_type_open = "fade";
      animation_type_close = "fade";
      animation_duration = {
        move = 200;
        open = 200;
        tag = 200;
        close = 150;
      };

      scratchpad_width_ratio = 0.8;
      scratchpad_height_ratio = 0.8;
      scratchpad_cross_monitor = 1;
    }
    // lib.optionalAttrs (stylixColors != null) {
      rootcolor = color stylixColors.base00 "ff";
      bordercolor = color stylixColors.base03 "ff";
      dropcolor = color stylixColors.base0B "55";
      splitcolor = color stylixColors.base08 "ff";
      focuscolor = color stylixColors.base0D "ff";
      maximizescreencolor = color stylixColors.base0B "ff";
      urgentcolor = color stylixColors.base08 "ff";
      scratchpadcolor = color stylixColors.base0E "ff";
      globalcolor = color stylixColors.base0C "ff";
      overlaycolor = color stylixColors.base0D "ff";
      shadowscolor = color stylixColors.base00 "a0";
    };
}
