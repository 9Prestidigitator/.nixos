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
      # experimental.swell-wayland.enable = true;

      theme = {
        active = "Reapertips Theme.ReaperThemeZip";
        packages = [
          inputs.reaper-flake.packages.${pkgs.stdenv.hostPlatform.system}.reapertips-theme
          inputs.reaper-flake.packages.${pkgs.stdenv.hostPlatform.system}.smooth6-theme
          inputs.reaper-flake.packages.${pkgs.stdenv.hostPlatform.system}.imperial-theme
          inputs.reaper-flake.packages.${pkgs.stdenv.hostPlatform.system}.part-theme
          inputs.reaper-flake.packages.${pkgs.stdenv.hostPlatform.system}.reark-theme
          inputs.reaper-flake.packages.${pkgs.stdenv.hostPlatform.system}.reaclassical-theme
          inputs.reaper-flake.packages.${pkgs.stdenv.hostPlatform.system}.xraym-analog-theme
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
