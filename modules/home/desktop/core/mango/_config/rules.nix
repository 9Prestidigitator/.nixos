{...}: {
  wayland.windowManager.mango.settings = {
    windowrule = [
      "isfloating:1,isopensilent:1,isoverlay:1,width:480,height:270,offsetx:100,offsety:100,title:Picture-in-Picture.*"
    ];
  };
}
