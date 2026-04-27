{
  inputs,
  self,
  ...
}: {
  flake.homeModules.niri = {
    imports = [
      # niri-flake is responsible for the configuration and desktop portal startup
      inputs.niri-flake.homeModules.config
      self.homeModules.wlr-which-key
      (inputs.import-tree ./_config)
      # noctalia as a dependency
      # self.homeModules.noctalia
    ];
  };
}
