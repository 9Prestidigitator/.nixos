{inputs, ...}: {
  flake.homeModules.spicetify = {pkgs, ...}: {
    imports = [inputs.spicetify-nix.homeManagerModules.default];

    programs.spicetify = let
      spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
    in {
      enable = true;
      theme = spicePkgs.themes.hazy;
      enabledExtensions = with spicePkgs.extensions; [
        adblock
        hidePodcasts
      ];
      enabledCustomApps = with spicePkgs.apps; [
        newReleases
        ncsVisualizer
      ];
    };

    persist.directories = [
      ".cache/spotify"
      ".config/spotify"
      ".local/share/spotify"
    ];
  };
}
