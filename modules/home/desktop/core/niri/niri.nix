{inputs, self, ...}: {
  flake.homeModules.niri = {
    imports = [
      inputs.niri-flake.homeModules.config
      self.homeModules.wlr-which-key
      (inputs.import-tree ./_config)
    ];

    persist.directories = [
      ".local/share/niri-screen-time"
    ];
  };
}
