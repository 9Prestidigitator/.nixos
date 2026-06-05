{inputs, ...}: {
  flake.homeModules.noctalia = {
    imports = [
      inputs.noctalia.homeModules.default
      (inputs.import-tree ./_config)
    ];

    persist.directories = [
      ".cache/noctalia"
      ".cache/cliphist"
      ".config/kdeconnect"
    ];
  };
}
