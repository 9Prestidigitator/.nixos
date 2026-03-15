{
  pkgs,
  lib,
  inputs,
  config,
  ...
}: let
  pkgsUnstable = import inputs.nixpkgs-unstable {
    system = pkgs.stdenv.hostPlatform.system;
    config = {
      allowUnfree = true;
    };
  };
in {
  config = lib.mkIf config.desktop.gaming.enable {
    programs.steam = {
      enable = true;
      protontricks.enable = false; # BROKEN
      extraCompatPackages = with pkgs; [
        proton-ge-bin
      ];
    };

    services.flatpak.packages = [
      "org.vinegarhq.Sober" # Roblox
      "com.github.Matoking.protontricks" # Not ideal but works great
    ];

    environment.systemPackages = with pkgs; [
      pkgsUnstable.eden
      prismlauncher
      heroic
      dolphin-emu
      melonDS
      azahar
    ];
  };
}
