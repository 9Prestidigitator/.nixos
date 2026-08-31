{
  inputs,
  self,
  ...
}: {
  flake.homeModules.umbriel = {
    imports = [
      inputs.umbriel.homeModules.default
      inputs.niri-flake.homeModules.config
      self.homeModules.wlr-which-key
      (inputs.import-tree ./_config)
    ];

    programs.umbriel.enable = true;
  };
}
