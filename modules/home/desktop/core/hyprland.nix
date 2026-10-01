{
  flake.homeModules.hyprland = {config, ...}: {
    wayland.windowManager.hyprland = {
      enable = true;
      systemd.enable = true;
      settings = {
        "$mod" = "SUPER";

        general = {
          layout = "scrolling";
          gaps_in = 4;
          gaps_out = 8;
          border_size = 0;
        };

        bind = [
          "$mod, Return, exec, ${config.desktop.terminal.name}"
          "$mod, Q, killactive"
          "$mod, H, layoutmsg, focus l"
          "$mod, L, layoutmsg, focus r"
        ];
      };
    };
  };
}
