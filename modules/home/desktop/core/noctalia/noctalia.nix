{inputs, ...}: {
  flake.homeModules.noctalia = {
    imports = [(inputs.import-tree ./_config)];

    persist.directories = [
      ".cache/noctalia"
      ".cache/cliphist"
    ];
  };
}
