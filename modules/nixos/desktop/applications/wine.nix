{
  flake.nixosModules.wine = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      latestWineForYabridge
      yabridgePatched
      yabridgectlPatched
      winetricks
      winePackages.fonts
      wineasio
    ];

    persist.userDirs = [
      ".wine"
      ".local/share/applications/wine"
      ".local/share/mime"
    ];
  };
}
