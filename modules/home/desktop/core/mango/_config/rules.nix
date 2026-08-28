{...}: {
  wayland.windowManager.mango.settings = {
    windowrule = [
      "isfloating:1,isopensilent:1,isglobal:1,isoverlay:1,width:480,height:270,offsetx:100,offsety:100,title:Picture in picture"
    ];
    layerrule = [
      "noblur:1,layer_name:noctalia-bar-exclusion-.*"
      "noblur:1,layer_name:noctalia-bar-trigger-.*"
      "noblur:1,layer_name:noctalia-background-.*"
      "noblur:1,layer_name:noctalia-bar-content-.*"
      "noblur:1,layer_name:noctalia-image-cache-renderer"

      "noshadow:1,layer_name:noctalia-bar-exclusion-.*"
      "noshadow:1,layer_name:noctalia-bar-trigger-.*"
      "noshadow:1,layer_name:noctalia-background-.*"
      "noshadow:1,layer_name:noctalia-bar-content-.*"
      "noshadow:1,layer_name:noctalia-image-cache-renderer"
    ];
  };
}
