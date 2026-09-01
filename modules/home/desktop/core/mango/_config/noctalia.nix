{
  config,
  lib,
  options,
  ...
}: {
  wayland.windowManager.mango.settings = lib.mkIf (options ? programs.noctalia.enable && config.programs.noctalia.enable) {
    bind = [
      "SUPER,n,setkeymode,noctalia"
      "SUPER,space,spawn,noctalia msg panel-toggle launcher"
      "NONE,XF86Favorites,spawn,noctalia msg panel-toggle control-center"
      "SUPER,Escape,spawn,noctalia msg session lock"
      "CTRL+ALT,Delete,spawn,noctalia msg panel-toggle session"
      "NONE,Print,spawn,noctalia msg screenshot-region"
      "SHIFT,Print,spawn,noctalia msg screenshot-fullscreen"
    ];
    bindr = ["SUPER,Super_L,spawn,noctalia msg panel-toggle control-center"];
    switchbind = [
      "fold,spawn,noctalia msg session lock"
    ];

    keymode = {
      noctalia.bindc = [
        "NONE,b,spawn,noctalia msg bluetooth-toggle"
        "NONE,b,setkeymode,default"
        "SHIFT,b,spawn,noctalia msg bar-toggle"
        "SHIFT,b,setkeymode,default"
        "SHIFT,d,spawn,noctalia msg dock-toggle"
        "SHIFT,d,setkeymode,default"
        "NONE,c,spawn,noctalia msg panel-toggle clipboard"
        "NONE,c,setkeymode,default"
        "NONE,i,spawn,noctalia msg caffeine-toggle"
        "NONE,i,setkeymode,default"
        "NONE,l,spawn,noctalia msg nightlight-toggle"
        "NONE,l,setkeymode,default"
        "NONE,n,setkeymode,noctalia-control-center"
        "NONE,o,spawn,noctalia msg panel-toggle control-center notifications"
        "NONE,o,setkeymode,default"
        "SHIFT,o,spawn,noctalia msg notification-dnd-toggle"
        "SHIFT,o,setkeymode,default"
        "NONE,p,setkeymode,noctalia-plugins"
        "NONE,s,spawn,noctalia msg settings-toggle"
        "NONE,s,setkeymode,default"
        "NONE,w,spawn,noctalia msg panel-toggle wallpaper"
        "NONE,w,setkeymode,default"
        "SHIFT,w,spawn,noctalia msg wallpaper-random"
        "SHIFT,w,setkeymode,default"
        "NONE,Escape,setkeymode,default"
        "NONE,Return,setkeymode,default"
      ];

      "noctalia-control-center".bindc = [
        "NONE,a,spawn,noctalia msg panel-toggle control-center audio"
        "NONE,a,setkeymode,default"
        "NONE,b,spawn,noctalia msg panel-toggle control-center bluetooth"
        "NONE,b,setkeymode,default"
        "NONE,c,spawn,noctalia msg panel-toggle control-center calendar"
        "NONE,c,setkeymode,default"
        "NONE,e,spawn,noctalia msg panel-toggle control-center network"
        "NONE,e,setkeymode,default"
        "NONE,m,spawn,noctalia msg panel-toggle control-center system"
        "NONE,m,setkeymode,default"
        "NONE,p,spawn,noctalia msg panel-toggle control-center power"
        "NONE,p,setkeymode,default"
        "NONE,s,spawn,noctalia msg panel-toggle control-center screen-time"
        "NONE,s,setkeymode,default"
        "NONE,t,spawn,noctalia msg panel-toggle tray-drawer"
        "NONE,t,setkeymode,default"
        "SHIFT,w,spawn,noctalia msg panel-toggle control-center weather"
        "SHIFT,w,setkeymode,default"
        "NONE,Escape,setkeymode,default"
        "NONE,Return,setkeymode,default"
      ];

      "noctalia-plugins".bindc = [
        "NONE,1,spawn,noctalia msg yuuto/calculator:panel"
        "NONE,1,setkeymode,default"
        "NONE,a,spawn,noctalia msg panel-toggle blackbartblues/audio-switcher:audio-switcher"
        "NONE,a,setkeymode,default"
        "SHIFT,a,spawn,noctalia msg panel-toggle cleboost/anilist:library"
        "SHIFT,a,setkeymode,default"
        "NONE,c,spawn,noctalia msg panel-toggle oldirtty/color_picker:panel"
        "NONE,c,setkeymode,default"
        "NONE,d,spawn,noctalia msg panel-toggle gustav0ar/drive-health:drives"
        "NONE,d,setkeymode,default"
        "NONE,f,spawn,noctalia msg panel-toggle nightwatch75/file-search:panel"
        "NONE,f,setkeymode,default"
        "NONE,k,spawn,noctalia msg panel-toggle kenn/keybind-cheatsheet:cheatsheet"
        "NONE,k,setkeymode,default"
        "NONE,l,spawn,noctalia msg panel-toggle alexander/screen-toolkit:panel"
        "NONE,l,setkeymode,default"
        "NONE,m,spawn,noctalia msg panel-toggle elijaharch/wl-screen-mirror:controls"
        "NONE,m,setkeymode,default"
        "NONE,n,spawn,noctalia msg panel-toggle noctalia/notes:panel"
        "NONE,n,setkeymode,default"
        "SHIFT,p,spawn,noctalia msg panel-toggle rxtsel/portctl:panel"
        "SHIFT,p,setkeymode,default"
        "NONE,q,spawn,noctalia msg panel-toggle yocraft/qrcode:panel"
        "NONE,q,setkeymode,default"
        "NONE,s,spawn,noctalia msg panel-toggle rylos/syncthing:panel"
        "NONE,s,setkeymode,default"
        "NONE,t,spawn,noctalia msg panel-toggle noctalia/timer:panel"
        "NONE,t,setkeymode,default"
        "SHIFT,t,spawn,noctalia msg panel-toggle nightwatch75/todo:panel"
        "SHIFT,t,setkeymode,default"
        "NONE,u,spawn,noctalia msg panel-toggle avivbintangaringga/nix-monitor:panel"
        "NONE,u,setkeymode,default"
        "NONE,w,spawn,noctalia msg panel-toggle noctalia/wallhaven:browser"
        "NONE,w,setkeymode,default"
        "SHIFT,w,spawn,noctalia msg panel-toggle tadomika_ari/w-engine:w-engine-panel"
        "SHIFT,w,setkeymode,default"
        "NONE,Escape,setkeymode,default"
        "NONE,Return,setkeymode,default"
      ];
    };
  };
}
