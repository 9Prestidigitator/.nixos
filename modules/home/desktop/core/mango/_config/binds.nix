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
        "SUPER,z,toggle_scratchpad"

        "SUPER,f,togglemaximizescreen"
        "SUPER+SHIFT,f,togglefullscreen"

        "SUPER,i,minimized"
        "SUPER+SHIFT,i,restore_minimized"

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
        "SUPER+ALT,h,tagmon,left,0"
        "SUPER+ALT,j,tagmon,down,0"
        "SUPER+ALT,k,tagmon,up,0"
        "SUPER+ALT,l,tagmon,right,0"

        "SUPER,u,viewtoleft,0"
        "SUPER,d,viewtoright,0"

        "SUPER,o,toggleoverview"
        "SUPER+SHIFT,o,toggleoverlay"
        "ALT,Tab,togglejump"

        "SUPER,n,switch_layout"
        "SUPER+SHIFT,n,setlayout,scroller"

        "SUPER,m,setkeymode,move"
        "SUPER,r,setkeymode,resize"

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
