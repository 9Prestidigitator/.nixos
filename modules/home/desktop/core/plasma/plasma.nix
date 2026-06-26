{inputs, ...}: {
  flake.homeModules.plasma = {
    imports = [
      inputs.plasma-manager.homeModules.plasma-manager
      (inputs.import-tree ./_config)
    ];
  };
}
