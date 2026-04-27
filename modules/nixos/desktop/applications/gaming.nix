{inputs, ...}: {
  flake.nixosModules.gaming = {pkgs, ...}: {
    imports = [inputs.steam-config-nix.nixosModules.default];
    programs.steam = {
      enable = true;
      gamescopeSession.enable = true;
      protontricks.enable = false; # BROKEN
      localNetworkGameTransfers.openFirewall = true;
      extraCompatPackages = with pkgs; [
        proton-ge-bin
      ];
    };
    services.flatpak.packages = [
      "org.vinegarhq.Sober" # Roblox
      "com.github.Matoking.protontricks" # Not ideal but works great
    ];
    environment.systemPackages = with pkgs; [
      eden
      prismlauncher
      heroic
      dolphin-emu
      melonds
      azahar
    ];
  };
}
