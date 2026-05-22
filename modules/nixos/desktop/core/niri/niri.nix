{inputs, ...}: {
  flake.nixosModules.niri = {pkgs, ...}: let
    system = pkgs.stdenv.hostPlatform.system;
  in {
    programs.niri = {
      enable = true;
      package = pkgs.niri-unstable;
    };

    services = {
      accounts-daemon.enable = true;
      gnome.gnome-online-accounts.enable = true;
    };

    programs = {
      evolution.enable = true;
      dconf.enable = true;
    };

    environment.sessionVariables = {
      XDG_CURRENT_DESKTOP = "niri";
      XDG_SESSION_DESKTOP = "niri";
      NIXOS_OZONE_WL = "1";
    };

    environment.systemPackages = with pkgs; [
      xwayland-satellite
      inputs.niri-float-sticky.packages.${system}.default
      inputs.niri-screen-time.packages.${system}.default
      seahorse
      polkit_gnome
      wl-clipboard
      file-roller
      pulseaudio
      imv
    ];

    persist = {
      directories = ["/var/lib/AccountsService"];
      userDirs = [
        ".local/state/niri-screen-time"
        ".local/share/evolution"
        ".config/evolution"
        ".config/goa-1.0"
      ];
    };
  };
}
