{inputs, ...}: {
  flake.homeModules.noctalia = {
    imports = [
      (inputs.import-tree ./_config)
      inputs.noctalia.homeModules.default
    ];
    disabledModules = ["programs/noctalia"];

    programs.noctalia = {
      enable = true;
      systemd.enable = true;
    };

    persist.directories = [
      ".cache/noctalia"
      ".cache/cliphist"
    ];
  };
}
