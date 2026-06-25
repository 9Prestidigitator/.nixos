{inputs, ...}: {
  flake.homeModules.noctalia = {
    imports = [
      inputs.noctalia.homeModules.default
      (inputs.import-tree ./_config)
    ];

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
