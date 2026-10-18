{...}: {
  wayland.windowManager.mango.settings = {
    window_rule = [
      "is_floating:1,is_open_silent:1,is_global:1,is_overlay:1,width:480,height:270,offset_x:100,offset_y:100,title:Picture in picture"
    ];
    layer_rule = [
      "no_blur:1,layer_name:noctalia-bar-exclusion-.*"
      "no_blur:1,layer_name:noctalia-bar-trigger-.*"
      "no_blur:1,layer_name:noctalia-background-.*"
      "no_blur:1,layer_name:noctalia-bar-content-.*"
      "no_blur:1,layer_name:noctalia-image-cache-renderer"

      "no_shadow:1,layer_name:noctalia-bar-exclusion-.*"
      "no_shadow:1,layer_name:noctalia-bar-trigger-.*"
      "no_shadow:1,layer_name:noctalia-background-.*"
      "no_shadow:1,layer_name:noctalia-bar-content-.*"
      "no_shadow:1,layer_name:noctalia-image-cache-renderer"
    ];
  };
}
