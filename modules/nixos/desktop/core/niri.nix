{
  inputs,
  self,
  ...
}: {
  flake.nixosModules.niri = {pkgs, ...}: let
    system = pkgs.stdenv.hostPlatform.system;
  in {
    imports = [self.nixosModules.super-tap];

    programs.niri = {
      enable = true;
      package = pkgs.niri;
    };

    services = {
      accounts-daemon.enable = true;
      gnome.gnome-online-accounts.enable = true;
    };

    programs.dconf.enable = true;

    xdg.portal.enable = true;

    environment.sessionVariables = {
      XDG_CURRENT_DESKTOP = "niri";
      XDG_SESSION_DESKTOP = "niri";
      NIXOS_OZONE_WL = "1";
      MOZ_ENABLE_WAYLAND = "1";
      SDL_VIDEODRIVER = "wayland";
    };

    environment.systemPackages = with pkgs; [
      xwayland-satellite
      inputs.niri-float-sticky.packages.${system}.default
      wl-clipboard
    ];

    persist = {
      directories = ["/var/lib/AccountsService"];
      userDirs = [
        ".local/share/gvfs-metadata"
        ".config/dconf"
        ".local/share/evolution"
        ".config/evolution"
        ".config/goa-1.0"
      ];
    };
  };
}
