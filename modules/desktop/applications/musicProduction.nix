{inputs, ...}: {
  flake.nixosModules.musicProduction = {pkgs, ...}: let
    pkgsStable = import inputs.nixpkgs-stable {
      system = pkgs.stdenv.hostPlatform.system;
      config.allowUnfree = true;
    };
  in {
    imports = [
      inputs.musnix.nixosModules.musnix
      inputs.self.nixosModules.overwitch
    ];
    musnix.enable = true;
    environment.systemPackages = with pkgs; [
      # hardware
      overwitch
      # DAWs
      bitwig6
      reaper
      reaper-sws-extension
      reaper-reapack-extension
      # plugins
      amplocker
      lsp-plugins
      x42-avldrums
      x42-plugins
      guitarix
      gxplugins-lv2
      dragonfly-reverb
      pkgsStable.surge
      # Utilities
      musescore
      paulxstretch
      papu
      easyeffects
      carla
      qpwgraph
    ];
  };
}
