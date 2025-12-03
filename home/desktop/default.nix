{
  lib,
  config,
  pkgs,
  niri,
  inputs,
  ...
}: {
  imports = [
    ./niri
    ./noctalia.nix
    inputs.spicetify-nix.homeManagerModules.default
  ];

  xdg = {
    userDirs = {
      enable = true;
      createDirectories = true;
    };
    configFile = {
      "kwalletrc".text = ''
        [Wallet]
        Enabled=false
        First Use=false
      '';
      "kdeglobals".text = ''
        [General]
        TerminalApplication=kitty
      '';
    };
  };

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
}
