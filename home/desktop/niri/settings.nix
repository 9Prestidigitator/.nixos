{
  pkgs,
  inputs,
  config,
  ...
}: {
  programs.niri = { 
  package = pkgs.niri;
  settings = with config.lib.stylix.colors; {
    spawn-at-startup = [];
    input = {
      keyboard = {
        xkb = {
          # You can set rules, model, layout, variant and options.
          # For more information, see xkeyboard-config(7).

          # For example:
          # layout = "us,ru";
          # options = "grp:win_space_toggle,compose:ralt,ctrl:nocaps";
        };
        numlock = true;
      };
      # Next sections include libinput settings.
      # Omitting settings disables them, or leaves them at their default values.
      # All commented-out settings here are examples, not defaults.
      touchpad = {
        tap = true;
        dwt = true;
        natural-scroll = true;
      };
      mouse = {
        accel-profile = "flat";
      };
      # Uncomment this to make the mouse warp to the center of newly focused windows.
      warp-mouse-to-focus.enable = true;
    };
    # You can configure outputs by their name, which you can find
    # by running `niri msg outputs` while inside a niri instance.
    # The built-in laptop monitor is usually called "eDP-1".
    # Find more information on the wiki:
    # https://yalter.github.io/niri/Configuration:-Outputs
    outputs = {
      "Red Hat, Inc. QEMU Monitor Unknown" = {
        scale = 1.5;
        position = {
          x = 0;
          y = 0;
        };
        mode = {
          width = 1920;
          height = 1080;
          refresh = null;
        };
      };
    };
    outputs = {
      "Microstep MSI G27C4 0x30333758" = {
        scale = 1;
        position = {
          x = 1920;
          y = 0;
        };
        mode = {
          width = 1920;
          height = 1080;
          refresh = 120.00;
        };
      };
    };
    outputs = {
      "Hewlett Packard HP 22cwa 6CM82100S4" = {
        scale = 1.2;
        position = {
          x = 0;
          y = 0;
        };
        mode = {
          width = 1920;
          height = 1080;
          refresh = 60.00;
        };
      };
    };
    overview = {
      workspace-shadow.enable = false;
      backdrop-color = "transparent";
    };
    layout = {
      focus-ring = {
        enable = false;
      };
      border = {
        enable = true;
        width = 3;
        active.color = "transparent";
        inactive.color = "transparent";
        urgent.color = "#9b0000";
      };
      preset-column-widths = [
        {proportion = 0.3333;}
        {proportion = 0.5;}
        {proportion = 0.6666;}
      ];
      default-column-width = {proportion = 0.5;};
      gaps = 5;
      center-focused-column = "never";
    };
    hotkey-overlay.skip-at-startup = false;
    screenshot-path = "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png";
  };
};
}
