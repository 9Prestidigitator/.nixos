{
  pkgs,
  lib,
  inputs,
  config,
  ...
}: let
  pkgsUnstable = import inputs.nixpkgs-unstable {
    system = pkgs.system;
    config = {
      allowUnfree = true;
    };
  };
in {
  imports = [
    inputs.musnix.nixosModules.musnix
    inputs.self.nixosModules.overwitch
  ];

  config = lib.mkIf config.desktop.musicprod.enable {
    musnix.enable = true;

    services.overwitch.enable = true;

    environment.systemPackages = with pkgs; [
      pkgsUnstable.bitwig-studio
      # bitwig-studio-latest
      paulxstretch
      # neuralnote
      # amplocker
      papu
      reaper
      reaper-sws-extension
      reaper-reapack-extension
      wineWowPackages.yabridge
      wineWowPackages.full
      winetricks
      winePackages.fonts
      wineasio
      yabridge
      yabridgectl
      overwitch
    ];
  };
}
