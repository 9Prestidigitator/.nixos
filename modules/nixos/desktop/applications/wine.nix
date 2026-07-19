{
  flake.nixosModules.wine = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      # wineStagingPatched
      # yabridgePatched
      # yabridgectlPatched
      wineWow64Packages.yabridge
      yabridge
      yabridgectl
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
