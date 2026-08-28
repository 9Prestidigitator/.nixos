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
          criteria = [{app_id = "REAPER";}];
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
    };
  };
}
