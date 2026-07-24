{inputs, ...}: {
  flake.homeModules.reaper = {
    config,
    pkgs,
    ...
  }: let
    reaper-config = "reaper-flake";
  in {
    imports = [
      inputs.reaper-flake.homeModules.reaper
      (inputs.import-tree ./_config)
    ];

    programs.reaper = {
      enable = true;
      configPath = "${config.xdg.configHome}/${reaper-config}";

      theme = {
        active = "Reapertips Theme.ReaperThemeZip";
        packages = [
          inputs.reaper-flake.packages.${pkgs.system}.smooth6-theme
          inputs.reaper-flake.packages.${pkgs.system}.reapertips-theme
        ];
      };

      swell.colortheme = {
        enable = true;
        preset = "stylix";
      };
    };

    persist.directories = [".config/${reaper-config}"];
  };
}
