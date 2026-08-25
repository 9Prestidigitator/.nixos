{inputs, ...}: {
  flake.homeModules.noctalia = {
    imports = [(inputs.import-tree ./_config)];

    programs.noctalia = {
      enable = true;
      systemd.enable = true;
    };
    desktop.shell = "noctalia";

    persist.directories = [
      ".cache/noctalia"
      ".cache/cliphist"
    ];
  };
}
