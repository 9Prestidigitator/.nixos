{
  config,
  inputs,
  lib,
  osConfig,
  ...
}: {
  wayland.windowManager.hyprland = with config.lib.stylix.colors; {
    settings = {
      "$mainMod" = "SUPER";
      "$terminal" = "kitty";

      general = {
        gaps_in = 2;
        gaps_out = 4;
        border_size = 2;
        "col.active_border" = "rgba(${base0B}ff) rgba(${base0D}80) 45deg";
        "col.inactive_border" = "rgba(00000000)";
        snap = {
          enabled = true;
          monitor_gap = 8;
          border_overlap = false;
        };
        # Set to true enable resizing windows by clicking and dragging on borders and gaps
        resize_on_border = false;

        # Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
        allow_tearing = false;
        layout = "dwindle";
      };

      decoration = {
        rounding = 20;
        rounding_power = 2;

        # Change transparency of focused and unfocused windows
        active_opacity = 1.0;
        inactive_opacity = 1.0;

        shadow = {
          enabled = false;
          range = 4;
          render_power = 3;
        };

        # https://wiki.hyprland.org/Configuring/Variables/#blur
        blur = {
          enabled = true;
          size = 7;
          passes = 4;

          special = false; # improves performance
          noise = 0.0117;
          vibrancy = 0.1696;
        };
      };

      dwindle = {
        pseudotile = true; # Master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
        preserve_split = true; # You probably want this
      };

      master = {
        new_status = "master";
        drop_at_cursor = false;
        new_on_active = "after";
      };

      misc = {
        force_default_wallpaper = 0; # Set to 0 or 1 to disable the anime mascot wallpapers
        disable_hyprland_logo = true; # If true disables the random hyprland logo / anime girl background. :(
        enable_swallow = false;
        focus_on_activate = false;
        initial_workspace_tracking = 1;
        allow_session_lock_restore = 1;
        middle_click_paste = false;
      };
    };
  };
}
