{inputs, ...}: {
  flake.nixosModules.gaming = {pkgs, ...}: {
    imports = [inputs.steam-config-nix.nixosModules.default];

    programs.steam = {
      enable = true;
      package = pkgs.millennium-steam;
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

    persist.userDirs = [
      ".config/heroic"
      ".config/dolphin-emu"
      ".config/melonDS"
      ".config/millennium"

      ".steam"
      ".factorio"
      "Games"

      ".cache/nvidia"
      ".cache/mesa_shader_cache"
      ".cache/mesa_shader_cache_db"
      ".cache/heroic"

      ".local/state/Heroic"
      ".local/share/PrismLauncher"
      ".local/share/Steam"
      ".local/share/eden"
      ".local/share/dolphin-emu"
      ".local/share/azahar-emu"
      ".local/share/millennium"
    ];
  };
}
