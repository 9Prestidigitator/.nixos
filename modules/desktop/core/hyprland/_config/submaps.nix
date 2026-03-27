{
  config,
  inputs,
  lib,
  osConfig,
  ...
}: {
  wayland.windowManager.hyprland = {
    submaps = {
      "launch" = {
        settings = {
          bind = [
            # Terminal programs
            ", N, exec, kitty --title \"Neovim\" nvim"
            ", N, submap, reset"
            ", T, exec, kitty --title \"tmux\" bash -c \"tmux a || tmux\""
            ", T, submap, reset"
            ", H, exec, kitty --title \"htop\" htop"
            ", H, submap, reset"
            ", W, exec, kitty --title \"Wifi\" nmtui"
            ", W, submap, reset"
            ", J, exec, qjackctl"
            ", J, submap, reset"
            # GUI programs
            ", B, exec, $browser"
            ", B, submap, reset"
            ", E, exec, $fileManager"
            ", E, submap, reset"
            ", S, exec, spotify"
            ", S, submap, reset"
            # exit
            ", escape, submap, reset"
          ];
        };
      };

      "move" = {
        settings = {
          bind = [
            ", H, movewindow, l"
            ", L, movewindow, r"
            ", K, movewindow, u"
            ", J, movewindow, d"
            "SHIFT CONTROL, H, moveactive, -20 0"
            "SHIFT CONTROL, L, moveactive, 20 0"
            "SHIFT CONTROL, K, moveactive, 0 -20"
            "SHIFT CONTROL, J, moveactive, 0 20"
            "SHIFT, H, moveactive, -180 0"
            "SHIFT, L, moveactive, 180 0"
            "SHIFT, K, moveactive, 0 -100"
            "SHIFT, J, moveactive, 0 100"
            # center
            ", M, centerwindow"
            ", M, submap, reset"
            # move to workspace
            ", 1, movetoworkspace, 1"
            ", 1, submap, reset"
            ", 2, movetoworkspace, 2"
            ", 2, submap, reset"
            ", 3, movetoworkspace, 3"
            ", 3, submap, reset"
            ", 4, movetoworkspace, 4"
            ", 4, submap, reset"
            ", 5, movetoworkspace, 5"
            ", 5, submap, reset"
            ", 6, movetoworkspace, 6"
            ", 6, submap, reset"
            ", 7, movetoworkspace, 7"
            ", 7, submap, reset"
            ", 8, movetoworkspace, 8"
            ", 8, submap, reset"
            ", 9, movetoworkspace, 9"
            ", 9, submap, reset"
            ", 0, movetoworkspace, 10"
            ", 0, submap, reset"
            # monitors
            ", period, movewindow, mon:+1"
            ", period, submap, reset"
            ", comma, movewindow, mon:-1"
            ", comma, submap, reset"
            "SHIFT, period, movecurrentworkspacetomonitor, +1"
            "SHIFT, period, submap, reset"
            "SHIFT, comma, movecurrentworkspacetomonitor, -1"
            "SHIFT, comma, submap, reset"
            # silent moves
            "SHIFT, 1, movetoworkspacesilent, 1"
            "SHIFT, 1, submap, reset"
            "SHIFT, 2, movetoworkspacesilent, 2"
            "SHIFT, 2, submap, reset"
            "SHIFT, 3, movetoworkspacesilent, 3"
            "SHIFT, 3, submap, reset"
            "SHIFT, 4, movetoworkspacesilent, 4"
            "SHIFT, 4, submap, reset"
            "SHIFT, 5, movetoworkspacesilent, 5"
            "SHIFT, 5, submap, reset"
            "SHIFT, 6, movetoworkspacesilent, 6"
            "SHIFT, 6, submap, reset"
            "SHIFT, 7, movetoworkspacesilent, 7"
            "SHIFT, 7, submap, reset"
            "SHIFT, 8, movetoworkspacesilent, 8"
            "SHIFT, 8, submap, reset"
            "SHIFT, 9, movetoworkspacesilent, 9"
            "SHIFT, 9, submap, reset"
            "SHIFT, 0, movetoworkspacesilent, 10"
            "SHIFT, 0, submap, reset"
            # relative
            ", V, movetoworkspace, +1"
            ", V, submap, reset"
            ", C, movetoworkspace, -1"
            ", C, submap, reset"
            "SHIFT, V, movetoworkspacesilent, +1"
            "SHIFT, V, submap, reset"
            "SHIFT, C, movetoworkspacesilent, -1"
            "SHIFT, C, submap, reset"
            # special workspaces
            ", Z, movetoworkspace, special:magic"
            ", Z, submap, reset"
            ", X, movetoworkspace, special:magic_alt"
            ", X, submap, reset"
            "SHIFT, Z, movetoworkspacesilent, special:magic"
            "SHIFT, Z, submap, reset"
            "SHIFT, X, movetoworkspacesilent, special:magic_alt"
            "SHIFT, X, submap, reset"
            # previous
            ", TAB, movetoworkspace, previous"
            "SHIFT, TAB, movetoworkspacesilent, previous"
            # dwindle
            ", N, pseudo"
            ", N, submap, reset"
            ", I, togglesplit"
            ", I, submap, reset"
            # floating
            ", P, pin"
            ", P, submap, reset"
            ", U, exec, hyprctl dispatch alterzorder top"
            ", U, submap, reset"
            ", D, exec, hyprctl dispatch alterzorder bottom"
            ", D, submap, reset"
            # resize handoff
            ", R, submap, resize"
            ", space, togglefloating"
            # exit
            ", escape, submap, reset"
          ];
        };
      };

      "screenshot" = {
        settings = {
          bind = [
            ", S, exec, caelestia shell picker openClip"
            ", S, submap, reset"
            ", D, exec, caelestia shell picker open"
            ", D, submap, reset"
            ", F, exec, caelestia shell picker openFreeze"
            ", F, submap, reset"
            ", escape, submap, reset"
          ];
        };
      };
    };
  };
}
