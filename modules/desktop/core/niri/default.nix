{
  lib,
  config,
  inputs,
  pkgs,
  ...
}: let
  cfg = config.desktop;
  isNiri = cfg.enable && cfg.wayCompositor == "niri";
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
        allow_empty_password = true;
        animation = "colormix";
        bigclock = "en";
        clock = "%c";
        lang = "en";
        numlock = true;
        vi_default_mode = "insert";
        vi_mode = true;
      };
    };

    services.gnome.evolution-data-server.enable = true;
    
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

    environment.systemPackages = with pkgs; [
      inputs.xwayland-satellite.packages.${pkgs.stdenv.hostPlatform.system}.default
      seahorse
      polkit_gnome
      gpu-screen-recorder
      wl-clipboard
      kdePackages.breeze-icons
      cliphist
      wlsunset
      pulseaudio
    ];

    home-manager.sharedModules = [
      inputs.niri.homeModules.config
      ./binds.nix
      ./settings.nix
      ./rules.nix
      ./outputs.nix
      ./swayidle.nix
      ./autostart.nix
    ];
  };
}
