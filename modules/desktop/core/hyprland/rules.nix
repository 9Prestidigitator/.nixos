{
  config,
  inputs,
  lib,
  osConfig,
  ...
}: {
  wayland.windowManager.hyprland.settings = {
    workspace = [
      "w[tv1], gapsout:0, gapsin:0"
      "f[1], gapsout:0, gapsin:0"
    ];

    windowrule = [
      "bordersize 0, floating:0, onworkspace:w[tv1]"
      "rounding 0, floating:0, onworkspace:w[tv1]"
      "bordersize 0, floating:0, onworkspace:f[1]"
      "rounding 0, floating:0, onworkspace:f[1]"

      # Fix some dragging issues with XWayland
      "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
    ];

    windowrulev2 = [
      "size 850 550, class:^(org.pulseaudio.pavucontrol)$"

      "float, class:^(steam)$, title:^(Friends List)$"
      "rounding 0, class:^(steam)$"

      "float, class:^(python3)$"
      "float, class:^(Matplotlib)$"
      "float, class:^(.*kvantum.*)$"
      "float, class:^(virt-manager)$"
      "float, class:^(feh)$"

      "float, title:^(Picture-in-Picture)$"
      "pin, title:^(Picture-in-Picture)$"
      "move 70% 70%, title:^(Picture-in-Picture)$"
      "size 515 290, title:^(Picture-in-Picture)$"
      "float, title:^(Picture in picture)$"
      "pin, title:^(Picture in picture)$"
      "move 70% 70%, title:^(Picture in picture)$"
      "size 515 290, title:^(Picture in picture)$"

      "float, title:^(\(default\) Active — QjackCtl)$"
      "move 1% 87%, title:^(\(default\) Active — QjackCtl)$"
      "size 560 100, title:^(\(default\) Active — QjackCtl)$"
      "tile, title:^(Graph — QjackCtl)$"
      "tile, title:^(Setup — QjackCtl)$"

      "rounding 0, class:^(REAPER)$"
      "noanim, class:^(REAPER)$"
      "noanim, class:REAPER,title:^(menu)$"
      "opaque, class:^(REAPER)$"
      "opaque, class:REAPER,title:^(menu)$"
      # windowrulev2 = move cursor,class:REAPER,floating:1
      # windowrulev2 = nofocus,class:REAPER,title:^(menu)$
      # windowrulev2 = nofocus,class:REAPER,title:^$

      "size 800 600, class:^(Alacritty)$"
      "size 800 600, class:^(kitty)$"
      "size 800 600, class:^(Signal)$"
    ];
  };
}
