{inputs, ...}: {
  flake.homeModules.sway = {osConfig, ...}: {
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
          criteria = [
            {class = "REAPER";}
            {app_id = "REAPER";}
            {app_id = "reaper";}
          ];
        };

        focus.followMouse = "no";

        # `swaymsg -t get_outputs`
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
