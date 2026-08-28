{inputs, ...}: {
  flake.homeModules.sway = {
    config,
    lib,
    osConfig,
    ...
  }: {
    imports = [(inputs.import-tree ./_config)];

    wayland.windowManager.sway = {
      enable = true;
      package = osConfig.programs.sway.package;
      systemd.enable = true;
      # SwayFX's config parser initializes a GLES renderer, unavailable in the
      # Nix build sandbox used by Home Manager's `sway -C` check.
      checkConfig = false;

      config = {
        bars = [];

        gaps = {
          inner = 10;
          outer = 5;
        };

        window = {
          border = 2;
          titlebar = false;
        };

        floating = {
          border = 2;
          titlebar = false;
          # REAPER uses an XWayland class on some builds and a Wayland app_id on
          # others, so match both variants rather than only its app_id.
          criteria = [
            {class = "REAPER";}
            {app_id = "REAPER";}
            {app_id = "reaper";}
          ];
        };

        focus.followMouse = "no";

        # Discover connector names with `swaymsg -t get_outputs` before enabling
        # an output. Sway positions are expressed in logical pixels.

        input."type:touchpad" = {
          tap = "enabled";
          natural_scroll = "enabled";
          dwt = "enabled";
        };

        seat."*".hide_cursor = "when-typing enable";
      };

      extraConfig = ''
        # SwayFX compositor effects.
        blur enable
        blur_passes 3
        blur_radius 5
        corner_radius 10
        shadows enable
      '';
    };
  };
}
