{
  inputs,
  self,
  ...
}: {
  flake.homeModules.labwc = {
    imports = [
      self.homeModules.wlr-which-key
      (inputs.import-tree ./_config)
    ];

    wayland.windowManager.labwc = {
      enable = true;
      systemd.enable = true;
      xwayland.enable = true;
    };
  };
}
