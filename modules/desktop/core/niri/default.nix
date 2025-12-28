{
  lib,
  config,
  inputs,
  pkgs,
  ...
}: let
  cfg = config.desktop;
  isNiri = cfg.enable && cfg.mode == "niri";
  isLaptop = config.networking.hostName != "ink";

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

    systemd.user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = ["graphical-session.target"];
      wants = ["graphical-session.target"];
      after = ["graphical-session.target"];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
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
          timeouts =
            [
              {
                timeout = 1000;
                command = "${noctalia-shell}/bin/noctalia-shell ipc call lockScreen lock";
              }
              {
                timeout = 1200;
                command = "${pkgs.niri} msg action power-off-monitors";
              }
            ]
            ++ lib.optionals isLaptop [
              {
                timeout = 1400;
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
