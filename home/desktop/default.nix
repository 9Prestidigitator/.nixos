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
    inputs.nixcord.homeModules.nixcord
  ];

  xdg = {
    userDirs = {
      enable = true;
      createDirectories = true;
    };
    terminal-exec = {
      enable = true;
      settings = {
        default = [
          "kitty.desktop"
        ];
      };
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
    systemdTarget = "niri.service";
    timeouts = [
      {
        timeout = 1200;
        command = "${pkgs.libnotify}/bin/notify-send 'Locking in 10 seconds'";
      }
      {
        timeout = 1210;
        command = "${noctalia-shell}/bin/noctalia-shell ipc call lockScreen lock";
      }
      {
        timeout = 1500;
        command = "${pkgs.niri} msg action power-off-monitors";
      }
      {
        timeout = 2000;
        command = "${pkgs.systemd}/bin/systemctl suspend";
      }
    ];
    events = [
      {
        event = "before-sleep";
        command = "${noctalia-shell}/bin/noctalia-shell ipc call lockScreen lock";
      }
    ];
  };

  programs.nixcord = {
    enable = true;
    discord = {
      vencord.enable = true;
    };
    config = {
      plugins = {
        alwaysAnimate.enable = true;
        betterFolders.enable = true;
        blurNsfw.enable = true;
        pinDMs.enable = true;
        volumeBooster.enable = true;
        youtubeAdblock.enable = true;
      };
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
