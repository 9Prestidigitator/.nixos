{self, ...}: {
  flake.homeModules.sway = {
    imports = [self.homeModules.wlr-which-key];

    wayland.windowManager.sway = {
      enable = true;
      systemd.enable = true;
    };
  };
}
