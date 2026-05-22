{
  inputs,
  self,
  ...
}: {
  flake.homeModules.noctalia = {
    imports = [
      inputs.noctalia.homeModules.default
      (inputs.import-tree ./_config)
    ];

    services = {
      kdeconnect = {
        enable = true;
        indicator = true;
      };
    };

    persist.directories = [
      ".cache/noctalia"
      ".cache/cliphist"
      ".config/kdeconnect"
    ];
  };
}
