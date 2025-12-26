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

      "$mainMod, Return, exec, $terminal"

      "$mainMod, escape, exec, caelestia shell lock lock"
      "$mainMod, space, exec, caelestia shell drawers toggle launcher"

      "$mainMod, TAB, workspace, previous"
      "$mainMod, D, workspace, +1"
      "$mainMod, U, workspace, -1"

      "$mainMod CONTROL, space, togglefloating"
      "$mainMod, F, fullscreen"
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
    ];

    gestures = {
      workspace_swipe = true;
    };
  };
}
