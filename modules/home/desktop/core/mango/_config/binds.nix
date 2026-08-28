{
  config,
  lib,
  ...
}: let
  terminal =
    if config.desktop.terminal.name == null
    then "foot"
    else config.desktop.terminal.name;
  tagBinds = lib.concatMap (
    tag: [
      "SUPER,${toString tag},view,${toString tag},0"
      "SUPER+CTRL,${toString tag},tag,${toString tag},0"
    ]
  ) (lib.range 1 9);
in {
  wayland.windowManager.mango.settings = {
    bind =
      [
        "SUPER,Return,spawn,${terminal}"
        "SUPER,q,killclient"
        "SUPER+SHIFT,r,reload_config"

        "SUPER+CTRL,space,togglefloating"
        "SUPER,g,toggleglobal"
        "SUPER+SHIFT,o,toggleoverlay"
        "SUPER,f,togglefullscreen"
        "SUPER,i,minimized"
        "SUPER+SHIFT,i,restore_minimized"
        "SUPER,z,toggle_scratchpad"

        "SUPER,h,focusdir,left"
        "SUPER,j,focusdir,down"
        "SUPER,k,focusdir,up"
        "SUPER,l,focusdir,right"
        "SUPER+CTRL,h,exchange_client,left"
        "SUPER+CTRL,j,exchange_client,down"
        "SUPER+CTRL,k,exchange_client,up"
        "SUPER+CTRL,l,exchange_client,right"

        "SUPER+SHIFT,h,focusmon,left"
        "SUPER+SHIFT,j,focusmon,down"
        "SUPER+SHIFT,k,focusmon,up"
        "SUPER+SHIFT,l,focusmon,right"
        "SUPER+CTRL+SHIFT,h,tagmon,left,0"
        "SUPER+CTRL+SHIFT,j,tagmon,down,0"
        "SUPER+CTRL+SHIFT,k,tagmon,up,0"
        "SUPER+CTRL+SHIFT,l,tagmon,right,0"

        "SUPER,u,viewtoleft,0"
        "SUPER,d,viewtoright,0"
        "SUPER,o,toggleoverview"
        "ALT,Tab,togglejump"
        "SUPER,n,switch_layout"
        "SUPER+SHIFT,n,setlayout,scroller"
        "SUPER,m,setkeymode,move"
        "SUPER,r,setkeymode,resize"
        "SUPER+CTRL,1,toggleview,1"
        "SUPER+CTRL,2,toggleview,2"
        "SUPER+CTRL,3,toggleview,3"
      ]
      ++ tagBinds;

    keymode = {
      move.bind = [
        "NONE,h,exchange_client,left"
        "NONE,j,exchange_client,down"
        "NONE,k,exchange_client,up"
        "NONE,l,exchange_client,right"
        "NONE,Escape,setkeymode,default"
        "NONE,Return,setkeymode,default"
      ];

      resize.bind = [
        "NONE,h,resizewin,-30,0"
        "NONE,j,resizewin,0,30"
        "NONE,k,resizewin,0,-30"
        "NONE,l,resizewin,30,0"
        "NONE,Escape,setkeymode,default"
        "NONE,Return,setkeymode,default"
      ];
    };

    gesturebind = [
      "NONE,left,3,focusdir,left"
      "NONE,right,3,focusdir,right"
      "NONE,up,3,focusdir,up"
      "NONE,down,3,focusdir,down"
      "NONE,left,4,viewtoleft_have_client"
      "NONE,right,4,viewtoright_have_client"
      "NONE,up,4,toggleoverview"
      "NONE,down,4,toggleoverview"
    ];

    mousebind = [
      "SUPER,btn_left,moveresize,curmove"
      "SUPER,btn_right,moveresize,curresize"
    ];
  };
}
