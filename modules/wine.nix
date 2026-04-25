{
  flake.nixosModules.wine = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      wineWow64Packages.yabridge
      yabridge
      yabridgectl
      winetricks
      winePackages.fonts
      wineasio
    ];
  };
}
