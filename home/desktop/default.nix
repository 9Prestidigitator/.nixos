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
    ./darkmode.nix

    inputs.spicetify-nix.homeManagerModules.default
  ];

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

  xdg.configFile."kwalletrc".text = ''
    [Wallet]
    Enabled=false
    First Use=false
  '';
  xdg.configFile."kdeglobals".text = ''
    [General]
    TerminalApplication=kitty
    widgetStyle=breeze
    colorScheme=BreezeDark
  '';
}
