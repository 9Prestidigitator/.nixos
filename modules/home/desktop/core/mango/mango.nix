{
  self,
  inputs,
  ...
}: {
  flake.homeModules.mango = {
    imports = [
      inputs.mangowm.hmModules.mango
      self.homeModules.wlr-which-key
      (inputs.import-tree ./_config)
    ];

    wayland.windowManager.mango = {
      enable = true;
      autostart_sh = "true";
      systemd = {
        enable = true;
        xdgAutostart = true;
      };
    };
  };
}
