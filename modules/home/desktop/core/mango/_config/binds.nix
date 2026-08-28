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

        "SUPER,f,togglefullscreen"
        "SUPER+CTRL,space,togglefloating"
        "SUPER,g,toggleglobal"
        "SUPER+SHIFT,g,toggleoverlay"

        "SUPER,z,toggle_scratchpad"

        "SUPER,b,setoption,borderpx,0"
        "SUPER+SHIFT,b,setoption,borderpx,2"

        "SUPER,x,centerwin"

        "SUPER,i,minimized"
        "SUPER+SHIFT,i,restore_minimized"

        "SUPER,j,focusstack,next"
        "SUPER,k,focusstack,prev"
        "SUPER,h,focusdir,left"
        "SUPER,l,focusdir,right"

        "SUPER+CTRL,h,exchange_client,left"
        "SUPER+CTRL,j,exchange_client,down"
        "SUPER+CTRL,k,exchange_client,up"
        "SUPER+CTRL,l,exchange_client,right"

        "SUPER+SHIFT,h,focusmon,left"
        "SUPER+SHIFT,j,focusmon,down"
        "SUPER+SHIFT,k,focusmon,up"
        "SUPER+SHIFT,l,focusmon,right"

        "SUPER+ALT,h,tagmon,left,0"
        "SUPER+ALT,j,tagmon,down,0"
        "SUPER+ALT,k,tagmon,up,0"
        "SUPER+ALT,l,tagmon,right,0"

        "SUPER+CTRL+SHIFT,h,smartmovewin,left"
        "SUPER+CTRL+SHIFT,j,smartmovewin,down"
        "SUPER+CTRL+SHIFT,k,smartmovewin,up"
        "SUPER+CTRL+SHIFT,l,smartmovewin,right"

        "SUPER+CTRL,u,tagtoleft,0"
        "SUPER+CTRL,d,tagtoright,0"
        "SUPER,u,viewtoleft,0"
        "SUPER,d,viewtoright,0"

        "SUPER,o,toggleoverview"
        "ALT,Tab,togglejump"
        "SUPER,grave,view,-1"
        "SUPER,Tab,focuslast"

        "SUPER,n,switch_layout"
        "SUPER+SHIFT,n,setlayout,scroller"
        "SUPER,minus,switch_proportion_preset,prev"
        "SUPER,equal,switch_proportion_preset,next"

        "SUPER,m,setkeymode,move"
        "SUPER,r,setkeymode,resize"
        "SUPER,a,setkeymode,layout"

        "SUPER+CTRL,1,toggleview,1"
        "SUPER+CTRL,2,toggleview,2"
        "SUPER+CTRL,3,toggleview,3"

        "NONE,XF86MonBrightnessUp,spawn,brightnessctl s +5%"
        "SHIFT,XF86MonBrightnessUp,spawn,brightnessctl s 100%"
        "NONE,XF86MonBrightnessDown,spawn,brightnessctl s 5%-"
        "SHIFT,XF86MonBrightnessDown,spawn,brightnessctl s 1%"

        "NONE,XF86AudioRaiseVolume,spawn,wpctl set-volume @DEFAULT_SINK@ 5%+"
        "NONE,XF86AudioLowerVolume,spawn,wpctl set-volume @DEFAULT_SINK@ 5%-"
        "NONE,XF86AudioMute,spawn,wpctl set-mute @DEFAULT_SINK@ toggle"
        "SHIFT,XF86AudioMute,spawn,wpctl set-mute @DEFAULT_SOURCE@ toggle"

        "NONE,XF86AudioNext,spawn,playerctl next"
        "NONE,XF86AudioPrev,spawn,playerctl previous"
        "NONE,XF86AudioPlay,spawn,playerctl play-pause"
      ]
      ++ tagBinds;

    keymode = {
      move.bind = [
        "NONE,h,exchange_client,left"
        "NONE,j,exchange_client,down"
        "NONE,k,exchange_client,up"
        "NONE,l,exchange_client,right"
        "SHIFT,h,scroller_stack,left"
        "SHIFT,j,scroller_stack,down"
        "SHIFT,k,scroller_stack,up"
        "SHIFT,l,scroller_stack,right"
        "NONE,1,tag,1,0"
        "NONE,2,tag,2,0"
        "NONE,3,tag,3,0"
        "NONE,4,tag,4,0"
        "NONE,5,tag,5,0"
        "NONE,6,tag,6,0"
        "NONE,7,tag,7,0"
        "NONE,8,tag,8,0"
        "NONE,9,tag,9,0"
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

      layout.bind = [
        "NONE,t,setlayout,tile"
        "NONE,s,setlayout,scroller"
        "NONE,v,setlayout,vertical_scroller"
        "NONE,m,setlayout,monocle"
        "NONE,g,setlayout,grid"
        "NONE,d,setlayout,dwindle"
        "NONE,f,setlayout,fair"
        "NONE,Escape,setkeymode,default"
        "NONE,Return,setkeymode,default"
      ];
    };

    gesturebind = [
      "NONE,right,3,focusdir,left"
      "NONE,left,3,focusdir,right"
      "NONE,down,3,focusdir,up"
      "NONE,up,3,focusdir,down"
      "NONE,right,4,viewtoleft"
      "NONE,left,4,viewtoright"

      "NONE,up,4,toggleoverview"
      "NONE,down,4,togglejump"
    ];

    mousebind = [
      "SUPER,btn_left,moveresize,curmove"
      "SUPER,btn_right,moveresize,curresize"

      # "NONE,btn_left,toggleoverview,-1"
      # "NONE,btn_right,killclient,0"
    ];

    axisbind = [
      "SUPER,UP,viewtoleft_have_client"
      "SUPER,DOWN,viewtoright_have_client"
    ];
  };
}
