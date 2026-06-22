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
      seahorse.enable = true;
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
      nautilus
      wl-clipboard
      file-roller
      pulseaudio
      imv
    ];

    xdg.mime.defaultApplications."inode/directory" = ["org.gnome.Nautilus.desktop"];

    persist = {
      directories = ["/var/lib/AccountsService"];
      userDirs = [
        ".local/share/nautilus"
        ".local/share/gvfs-metadata"
        ".config/dconf"
        ".local/share/evolution"
        ".config/evolution"
        ".config/goa-1.0"
      ];
    };
  };
}
