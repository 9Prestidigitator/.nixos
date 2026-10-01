{
  flake.homeModules.hyprland = {config, ...}: {
    wayland.windowManager.hyprland = {
      enable = true;
      systemd.enable = true;

      settings = {
        config = {
          general = {
            layout = "scrolling";
            gaps_in = 4;
            gaps_out = 8;
            border_size = 0;
          };

          scrolling = {
            fullscreen_on_one_column = true;
          };
        };
      };

      extraConfig = ''
        hl.bind("SUPER + Return",
          hl.dsp.exec_cmd("${config.desktop.terminal.name}"))

        hl.bind("SUPER + Q",
          hl.dsp.window.close())

        hl.bind("SUPER + H",
          hl.dsp.layout("focus l"))

        hl.bind("SUPER + L",
          hl.dsp.layout("focus r"))
      '';
    };
  };
}
