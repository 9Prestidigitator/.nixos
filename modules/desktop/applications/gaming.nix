{inputs, ...}: {
  flake.nixosModules.gaming = {pkgs, ...}: let
    pkgsUnstable = import inputs.nixpkgs-unstable {
      system = pkgs.stdenv.hostPlatform.system;
      config = {
        allowUnfree = true;
      };
    };
  in {
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
      pkgsUnstable.eden
      prismlauncher
      heroic
      dolphin-emu
      melonDS
      azahar
    ];
  };

  flake.homeModules.gaming = {
    imports = [inputs.steam-config-nix.homeModules.default];
    programs.steam.config = {
      enable = true;
      # closeSteam = true;
      defaultCompatTool = "proton_experimental";
      apps = {
        chaos-head-noah = {
          id = 1961950;
          compatTool = "proton_9";
        };
        steins-gate = {
          id = 412830;
          compatTool = "proton_8";
        };
        robotics-notes-elite = {
          id = 1111380;
          compatTool = "proton_9";
        };
        chaos-child = {
          id = 970570;
          compatTool = "proton_8";
        };
        steins-gate-0 = {
          id = 825630;
          compatTool = "proton_8";
        };
        robotics-notes-dash = {
          id = 1111390;
          compatTool = "proton_9";
        };
      };
    };
  };
}
