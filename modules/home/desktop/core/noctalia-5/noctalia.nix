{inputs, ...}: {
  flake.homeModules.noctalia-5 = {
    imports = [
      inputs.noctalia-5.homeModules.default
      (inputs.import-tree ./_config)
    ];

    persist.directories = [
      ".cache/noctalia"
      ".cache/cliphist"
    ];
  };
}
