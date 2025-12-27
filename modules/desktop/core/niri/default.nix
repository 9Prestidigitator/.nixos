{
  lib,
  config,
  inputs,
  pkgs,
  ...
}: let
  cfg = config.desktop;
  isNiri = cfg.enable && cfg.mode == "niri";

  noctalia-shell = inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default;
in {
  imports = [
    ./noctalia
  ];

  config = lib.mkIf isNiri {
    programs.niri = {
      enable = true;
      package = pkgs.niri;
    };

    # Probably going to change. Doesn't fit noctalia
    services.displayManager.ly = {
      enable = true;
      settings = {
        allow_empty_password = false;
        animation = "colormix";
        bigclock = "en";
        clock = "%c";
        lang = "en";
        numlock = true;
        vi_default_mode = "insert";
        vi_mode = true;
      };
    };

    xdg.portal = {
      enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-gnome
        pkgs.xdg-desktop-portal-gtk
      ];
    };

    home-manager.sharedModules = [
      inputs.niri.homeModules.config
      ./binds.nix
      ./settings.nix
      ./rules.nix
      ./outputs.nix
      {
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
      }
    ];
  };
}
