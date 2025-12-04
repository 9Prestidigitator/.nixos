{
  lib,
  config,
  pkgs,
  niri,
  inputs,
  ...
}: let
  noctalia-shell = inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default;
in {
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

  services.swayidle = {
    enable = true;
    package = pkgs.swayidle;
    timeouts = [
      {
        timeout = 5;
        command = "${noctalia-shell} ipc call lockScreen lock";
      }
      {
        timeout = 180;
        command = "${pkgs.libnotify}/bin/notify-send 'Locking in 5 seconds'";
      }
      {
        timeout = 190;
        command = "${pkgs.niri} msg action power-off-monitors";
      }
      {
        timeout = 195;
        command = "${pkgs.systemd}/bin/systemctl suspend";
      }
    ];
    events = [
      {
        event = "before-sleep";
        command = "${noctalia-shell} ipc call lockScreen lock";
      }
    ];
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
