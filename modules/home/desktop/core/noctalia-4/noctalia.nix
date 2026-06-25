{inputs, ...}: {
  flake.homeModules.noctalia-4 = {
    imports = [
      inputs.noctalia-4.homeModules.default
      (inputs.import-tree ./_config)
    ];

    persist.directories = [
      ".cache/noctalia"
      ".cache/cliphist"
      ".config/kdeconnect"
    ];
  };
}
