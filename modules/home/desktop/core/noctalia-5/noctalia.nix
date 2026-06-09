{inputs, ...}: {
  flake.homeModules.noctalia-5 = {
    imports = [
      inputs.noctalia-5.homeModules.default
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
