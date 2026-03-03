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

    programs.evolution.enable = true;
    programs.dconf.enable = true;
    services.accounts-daemon.enable = true;
    services.gnome.gnome-online-accounts.enable = true;
    services.gnome.evolution-data-server.enable = true;

    xdg = {
      portal = {
        enable = true;
        extraPortals = [
          pkgs.xdg-desktop-portal-gnome
          pkgs.xdg-desktop-portal-gtk
        ];
      };
      mime = {
        defaultApplications = {
          "x-scheme-handler/http" = ["com.brave.Browser.desktop"];
          "x-scheme-handler/https" = ["com.brave.Browser.desktop"];
          "application/pdf" = [
            "org.pwmt.zathura.desktop"
            "com.brave.Browser.desktop"
          ];
          "inode/directory" = ["org.gnome.Nautilus.desktop"];
          "image/png" = ["imv.desktop"];
        };
      };
    };

    programs.kdeconnect.enable = true;

    environment.systemPackages = with pkgs; [
      (inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default.override {calendarSupport = true;})
      inputs.xwayland-satellite.packages.${pkgs.stdenv.hostPlatform.system}.default
      seahorse
      polkit_gnome
      gpu-screen-recorder
      wl-clipboard
      kdePackages.breeze-icons
      cliphist
      wlsunset
      pulseaudio
      imv
    ];

    home-manager.sharedModules = [
      inputs.niri.homeModules.config
      ./binds.nix
      ./settings.nix
      ./rules.nix
      ./outputs.nix
      ./autostart.nix
    ];
  };
}
