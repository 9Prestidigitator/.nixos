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
