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
      systemd = {
        enable = true;
        extraCommands = [
          "systemctl --user reset-failed"
          "systemctl --user start graphical-session.target mango-session.target"
        ];
      };
    };
  };
}
