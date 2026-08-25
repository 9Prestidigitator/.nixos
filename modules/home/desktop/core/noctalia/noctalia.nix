{inputs, ...}: {
  flake.homeModules.noctalia = {
    imports = [(inputs.import-tree ./_config)];

    desktop.shell = "noctalia";

    persist.directories = [
      ".cache/noctalia"
      ".cache/cliphist"
    ];
  };
}
