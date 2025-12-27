{
  config,
  inputs,
  lib,
  osConfig,
  ...
}: {
  wayland.windowManager.hyprland.settings = {
    bind = [
      "$mainMod, H, movefocus, l"
      "$mainMod, L, movefocus, r"
      "$mainMod, K, movefocus, u"
      "$mainMod, J, movefocus, d"

      "$mainMod, escape, exec, caelestia shell lock lock"
      "$mainMod, space, exec, caelestia shell drawers toggle launcher"
      "$mainMod, n, exec, caelestia shell drawers toggle sidebar"

      "$mainMod, Return, exec, $terminal"
      "$mainMod, G, submap, launch"
      "$mainMod, M, submap, move"

      "$mainMod, TAB, workspace, previous"
      "$mainMod, D, workspace, +1"
      "$mainMod, U, workspace, -1"
      "$mainMod, period, focusmonitor, +1"
      "$mainMod, comma, focusmonitor, -1"

      "$mainMod CONTROL, space, togglefloating"
      "$mainMod, F, fullscreen"
      "$mainMod, P, pin"
      "$mainMod, Q, killactive"

      "$mainMod, 1, workspace, 1"
      "$mainMod, 2, workspace, 2"
      "$mainMod, 3, workspace, 3"
      "$mainMod, 4, workspace, 4"
      "$mainMod, 5, workspace, 5"
      "$mainMod, 6, workspace, 6"
      "$mainMod, 7, workspace, 7"
      "$mainMod, 8, workspace, 8"
      "$mainMod, 9, workspace, 9"
      "$mainMod, 0, workspace, 10"

      ", XF86AudioNext, exec, playerctl next"
      ", XF86AudioPause, exec, playerctl play-pause"
      ", XF86AudioPlay, exec, playerctl play-pause"
      ", XF86AudioPrev, exec, playerctl previous"
    ];

    bindm = [
      "$mainMod, mouse:272, movewindow"
      "$mainMod, mouse:273, resizewindow"
    ];

    submaps = {
      "launch" = {
        settings = {
          bind = [
            # Terminal programs
            "bind = , N, exec, kitty --title \"Neovim\" nvim"
            "bind = , N, submap, reset"
            "bind = , T, exec, kitty --title \"tmux\" bash -c \"tmux a || tmux\""
            "bind = , T, submap, reset"
            "bind = , H, exec, kitty --title \"htop\" htop"
            "bind = , H, submap, reset"
            "bind = , W, exec, kitty --title \"Wifi\" nmtui"
            "bind = , W, submap, reset"
            "bind = , J, exec, qjackctl"
            "bind = , J, submap, reset"
            # GUI programs
            "bind = , B, exec, $browser"
            "bind = , B, submap, reset"
            "bind = , E, exec, $fileManager"
            "bind = , E, submap, reset"
            "bind = , S, exec, spotify"
            "bind = , S, submap, reset"
            # exit
            "bind = , escape, submap, reset"
            "submap = reset"
          ];
        };
      };

      "move" = {
        settings = {
          bind = [
            "bind = , H, movewindow, l"
            "bind = , L, movewindow, r"
            "bind = , K, movewindow, u"
            "bind = , J, movewindow, d"
            "bind = SHIFT CONTROL, H, moveactive, -20 0"
            "bind = SHIFT CONTROL, L, moveactive, 20 0"
            "bind = SHIFT CONTROL, K, moveactive, 0 -20"
            "bind = SHIFT CONTROL, J, moveactive, 0 20"
            "bind = SHIFT, H, moveactive, -180 0"
            "bind = SHIFT, L, moveactive, 180 0"
            "bind = SHIFT, K, moveactive, 0 -100"
            "bind = SHIFT, J, moveactive, 0 100"
            # center
            "bind = , M, centerwindow"
            "bind = , M, submap, reset"
            # move to workspace
            "bind = , 1, movetoworkspace, 1"
            "bind = , 1, submap, reset"
            "bind = , 2, movetoworkspace, 2"
            "bind = , 2, submap, reset"
            "bind = , 3, movetoworkspace, 3"
            "bind = , 3, submap, reset"
            "bind = , 4, movetoworkspace, 4"
            "bind = , 4, submap, reset"
            "bind = , 5, movetoworkspace, 5"
            "bind = , 5, submap, reset"
            "bind = , 6, movetoworkspace, 6"
            "bind = , 6, submap, reset"
            "bind = , 7, movetoworkspace, 7"
            "bind = , 7, submap, reset"
            "bind = , 8, movetoworkspace, 8"
            "bind = , 8, submap, reset"
            "bind = , 9, movetoworkspace, 9"
            "bind = , 9, submap, reset"
            "bind = , 0, movetoworkspace, 10"
            "bind = , 0, submap, reset"
            # monitors
            "bind = , period, movewindow, mon:+1"
            "bind = , period, submap, reset"
            "bind = , comma, movewindow, mon:-1"
            "bind = , comma, submap, reset"
            "bind = SHIFT, period, movecurrentworkspacetomonitor, +1"
            "bind = SHIFT, period, submap, reset"
            "bind = SHIFT, comma, movecurrentworkspacetomonitor, -1"
            "bind = SHIFT, comma, submap, reset"
            # silent moves
            "bind = SHIFT, 1, movetoworkspacesilent, 1"
            "bind = SHIFT, 1, submap, reset"
            "bind = SHIFT, 2, movetoworkspacesilent, 2"
            "bind = SHIFT, 2, submap, reset"
            "bind = SHIFT, 3, movetoworkspacesilent, 3"
            "bind = SHIFT, 3, submap, reset"
            "bind = SHIFT, 4, movetoworkspacesilent, 4"
            "bind = SHIFT, 4, submap, reset"
            "bind = SHIFT, 5, movetoworkspacesilent, 5"
            "bind = SHIFT, 5, submap, reset"
            "bind = SHIFT, 6, movetoworkspacesilent, 6"
            "bind = SHIFT, 6, submap, reset"
            "bind = SHIFT, 7, movetoworkspacesilent, 7"
            "bind = SHIFT, 7, submap, reset"
            "bind = SHIFT, 8, movetoworkspacesilent, 8"
            "bind = SHIFT, 8, submap, reset"
            "bind = SHIFT, 9, movetoworkspacesilent, 9"
            "bind = SHIFT, 9, submap, reset"
            "bind = SHIFT, 0, movetoworkspacesilent, 10"
            "bind = SHIFT, 0, submap, reset"
            # relative
            "bind = , V, movetoworkspace, +1"
            "bind = , V, submap, reset"
            "bind = , C, movetoworkspace, -1"
            "bind = , C, submap, reset"
            "bind = SHIFT, V, movetoworkspacesilent, +1"
            "bind = SHIFT, V, submap, reset"
            "bind = SHIFT, C, movetoworkspacesilent, -1"
            "bind = SHIFT, C, submap, reset"
            # special workspaces
            "bind = , Z, movetoworkspace, special:magic"
            "bind = , Z, submap, reset"
            "bind = , X, movetoworkspace, special:magic_alt"
            "bind = , X, submap, reset"
            "bind = SHIFT, Z, movetoworkspacesilent, special:magic"
            "bind = SHIFT, Z, submap, reset"
            "bind = SHIFT, X, movetoworkspacesilent, special:magic_alt"
            "bind = SHIFT, X, submap, reset"
            # previous
            "bind = , TAB, movetoworkspace, previous"
            "bind = SHIFT, TAB, movetoworkspacesilent, previous"
            # dwindle
            "bind = , N, pseudo"
            "bind = , N, submap, reset"
            "bind = , I, togglesplit"
            "bind = , I, submap, reset"
            # floating
            "bind = , P, pin"
            "bind = , P, submap, reset"
            "bind = , U, exec, hyprctl dispatch alterzorder top"
            "bind = , U, submap, reset"
            "bind = , D, exec, hyprctl dispatch alterzorder bottom"
            "bind = , D, submap, reset"
            # resize handoff
            "bind = , R, submap, resize"
            "bind = , space, togglefloating"
            # exit
            "bind = , escape, submap, reset"
            "submap = reset"
          ];
        };
      };
    };

    gesture = [
      "3, horizontal, workspace"
      "3, vertical, special, magic"
      "4, vertical, special, magic_alt"
    ];

    input = {
      kb_layout = "us";

      numlock_by_default = true;
      follow_mouse = 0;
      float_switch_override_focus = 0;

      sensitivity = 0; # -1.0 - 1.0, 0 means no modification.

      touchpad = {
        natural_scroll = true;
      };
    };

    device = [
      {
        name = "steelseries-steelseries-aerox-3";
        accel_profile = "flat";
        sensitivity = 0.0;
      }
      {
        name = "logitech-usb-laser-mouse";
        accel_profile = "flat";
        sensitivity = 0.5;
      }
    ];

    cursor = {
      no_hardware_cursors = true;
      inactive_timeout = 90;
      persistent_warps = true;
      no_warps = false;
    };
  };
}
