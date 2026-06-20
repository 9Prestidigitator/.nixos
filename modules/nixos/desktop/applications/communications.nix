{
  flake.nixosModules.communications = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      signal-desktop
      signal-cli
      element-desktop
    ];

    services.flatpak.packages = ["app.fluxer.Fluxer"];

    persist.userDirs = [
      ".config/Signal"
      ".config/Element"
    ];
  };
}
