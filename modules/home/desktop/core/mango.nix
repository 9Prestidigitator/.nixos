{
  self,
  inputs,
  ...
}: {
  flake.homeModules.mango = {
    imports = [
      inputs.mangowm.hmModules.mango
      self.homeModules.wlr-which-key
    ];

    wayland.windowManager.mango = {
      enable = true;
      systemd.enable = true;
    };
  };
}
