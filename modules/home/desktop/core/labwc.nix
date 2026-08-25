{
  flake.homeModules.labwc = {
    wayland.windowManager.labwc = {
      enable = true;
      systemd.enable = true;
    };
  };
}
