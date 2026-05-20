{inputs, ...}: {
  flake.nixosModules.niri = {pkgs, ...}: {
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
      inputs.niri-float-sticky.packages.${pkgs.system}.default
      inputs.niri-screen-time.packages.${pkgs.system}.default
      seahorse
      polkit_gnome
      wl-clipboard
      file-roller
      pulseaudio
      imv
    ];
  };
}
