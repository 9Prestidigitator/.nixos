{inputs, ...}: {
  flake.nixosModules.nix = {lib, ...}: {
    programs = {
      nh.enable = true;
      nix-ld.enable = true;
    };

    nixpkgs = {
      config.allowUnfree = true;
      overlays = [
        inputs.audio-nix.overlays.default
        inputs.niri-flake.overlays.niri
        inputs.maxpkgs.overlays.default
      ];
    };
    nix = {
      gc = {
        automatic = lib.mkDefault true;
        dates = lib.mkDefault "weekly";
        options = lib.mkDefault "--delete-older-than 7d";
      };
      settings = {
        experimental-features = ["nix-command" "flakes"];
        allowed-users = ["@wheel"];
        trusted-users = ["@wheel" "nixremote"];
      };
    };
  };
}
