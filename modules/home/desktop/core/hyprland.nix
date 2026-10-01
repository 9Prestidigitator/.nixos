{
  flake.homeModules.hyprland = {config, ...}: {
    wayland.windowManager.hyprland = {
      enable = true;
      systemd.enable = true;

      settings.config = {
        general = {
          layout = "scrolling";
          gaps_in = 4;
          gaps_out = 7;
          border_size = 0;
          resize_on_border = true;
        };

        input = {
          numlock_by_default = true;
          accel_profile = "flat";
          follow_mouse = 0;
          touchpad = {
            tap_to_click = true;
            disable_while_typing = true;
            natural_scroll = true;
          };
        };

        scrolling = {
          column_width = 0.5;
          explicit_column_widths = "0.3333, 0.5, 0.6666";
          fullscreen_on_one_column = true;
          wrap_focus = false;
          wrap_swapcol = false;
        };

        binds = {
          movefocus_cycles_fullscreen = true;
          scroll_event_delay = 120;
        };

        gestures = {
          workspace_swipe_distance = 300;
          workspace_swipe_create_new = false;
          workspace_swipe_forever = false;
        };

        xwayland.force_zero_scaling = true;

        misc = {
          disable_hyprland_logo = true;
          force_default_wallpaper = 0;
        };
      };

      extraConfig = ''
        local mod = "SUPER"

        hl.gesture({
          fingers = 3,
          direction = "up",
          action = function()
            hl.dispatch(hl.dsp.focus({ workspace = "e+1" }))
          end,
        })
        hl.gesture({
          fingers = 3,
          direction = "down",
          action = function()
            hl.dispatch(hl.dsp.focus({ workspace = "e-1" }))
          end,
        })

        hl.curve("snappy", {
          type = "bezier",
          points = { { 0.2, 0.9 }, { 0.2, 1.0 } },
        })
        hl.animation({
          leaf = "windows",
          enabled = true,
          speed = 1.5,
          bezier = "snappy",
          style = "slide",
        })
        hl.animation({
          leaf = "windowsMove",
          enabled = true,
          speed = 1.2,
          bezier = "snappy",
        })
        hl.animation({
          leaf = "workspaces",
          enabled = true,
          speed = 1.8,
          bezier = "snappy",
          style = "slidevert 15%",
        })
        hl.animation({ leaf = "fadeIn", enabled = false })
        hl.animation({ leaf = "fadeOut", enabled = false })

        hl.bind(mod .. " + Return",
          hl.dsp.exec_cmd("${config.desktop.terminal.name}"))
        hl.bind(mod .. " + Q", hl.dsp.window.close())
        hl.bind(mod .. " + F",
          hl.dsp.window.fullscreen({ mode = "maximized" }))
        hl.bind(mod .. " + SHIFT + F",
          hl.dsp.window.fullscreen({ mode = "fullscreen" }))
        hl.bind(mod .. " + CTRL + Space",
          hl.dsp.window.float({ action = "toggle" }))

        hl.bind(mod .. " + H", hl.dsp.layout("focus l"))
        hl.bind(mod .. " + L", hl.dsp.layout("focus r"))
        hl.bind(mod .. " + J", hl.dsp.focus({ direction = "down" }))
        hl.bind(mod .. " + K", hl.dsp.focus({ direction = "up" }))
        hl.bind(mod .. " + Left", hl.dsp.layout("focus l"))
        hl.bind(mod .. " + Right", hl.dsp.layout("focus r"))
        hl.bind(mod .. " + Down", hl.dsp.focus({ direction = "down" }))
        hl.bind(mod .. " + Up", hl.dsp.focus({ direction = "up" }))

        hl.bind(mod .. " + CTRL + H", hl.dsp.layout("swapcol l"))
        hl.bind(mod .. " + CTRL + L", hl.dsp.layout("swapcol r"))
        hl.bind(mod .. " + CTRL + J",
          hl.dsp.window.move({ direction = "down" }))
        hl.bind(mod .. " + CTRL + K",
          hl.dsp.window.move({ direction = "up" }))
        hl.bind(mod .. " + CTRL + Left", hl.dsp.layout("swapcol l"))
        hl.bind(mod .. " + CTRL + Right", hl.dsp.layout("swapcol r"))
        hl.bind(mod .. " + CTRL + Down",
          hl.dsp.window.move({ direction = "down" }))
        hl.bind(mod .. " + CTRL + Up",
          hl.dsp.window.move({ direction = "up" }))

        hl.bind(mod .. " + U", hl.dsp.focus({ workspace = "e-1" }))
        hl.bind(mod .. " + D", hl.dsp.focus({ workspace = "e+1" }))
        hl.bind(mod .. " + Page_Up", hl.dsp.focus({ workspace = "e-1" }))
        hl.bind(mod .. " + Page_Down", hl.dsp.focus({ workspace = "e+1" }))
        hl.bind(mod .. " + Tab", hl.dsp.focus({ workspace = "previous" }))

        hl.bind(mod .. " + CTRL + U",
          hl.dsp.window.move({ workspace = "e-1", follow = false }))
        hl.bind(mod .. " + CTRL + D",
          hl.dsp.window.move({ workspace = "e+1", follow = false }))
        hl.bind(mod .. " + CTRL + Page_Up",
          hl.dsp.window.move({ workspace = "e-1", follow = false }))
        hl.bind(mod .. " + CTRL + Page_Down",
          hl.dsp.window.move({ workspace = "e+1", follow = false }))

        for workspace = 1, 9 do
          hl.bind(mod .. " + " .. workspace,
            hl.dsp.focus({ workspace = workspace }))
          hl.bind(mod .. " + CTRL + " .. workspace,
            hl.dsp.window.move({ workspace = workspace, follow = false }))
        end

        hl.bind(mod .. " + R", hl.dsp.layout("colresize -conf"))
        hl.bind(mod .. " + Minus", hl.dsp.layout("colresize -0.1"),
          { repeating = true })
        hl.bind(mod .. " + Equal", hl.dsp.layout("colresize +0.1"),
          { repeating = true })

        hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
        hl.bind(mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })
        hl.bind(mod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))
        hl.bind(mod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))

        local lockedRepeat = { locked = true, repeating = true }
        local locked = { locked = true }
        hl.bind("XF86Favorites",
          hl.dsp.exec_cmd("noctalia msg panel-toggle control-center"))
        hl.bind("XF86AudioRaiseVolume",
          hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), lockedRepeat)
        hl.bind("XF86AudioLowerVolume",
          hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), lockedRepeat)
        hl.bind("XF86AudioMute",
          hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), locked)
        hl.bind("XF86AudioMicMute",
          hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), locked)
        hl.bind("XF86MonBrightnessUp",
          hl.dsp.exec_cmd("brightnessctl --class=backlight set +5%"), lockedRepeat)
        hl.bind("XF86MonBrightnessDown",
          hl.dsp.exec_cmd("brightnessctl --class=backlight set 5%-"), lockedRepeat)
        hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), locked)
        hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), locked)
        hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), locked)
        hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), locked)
      '';
    };
  };
}
