{
  description = "NixOS configuration for home systems.";

  outputs = inputs: inputs.flake-parts.lib.mkFlake {inherit inputs;} (inputs.import-tree ./modules);

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.11";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";

    impermanence.url = "github:nix-community/impermanence";
    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    wrappers.url = "github:BirdeeHub/nix-wrapper-modules";
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    maxpkgs.url = "github:9Prestidigitator/maxpkgs";
    maxvim.url = "github:9prestidigitator/nvim";

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-flatpak.url = "github:gmodena/nix-flatpak/latest";

    musnix.url = "github:musnix/musnix";
    audio-nix = {
      url = "github:polygon/audio.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri-flake.url = "github:9prestidigitator/niri-flake";
    niri-float-sticky.url = "github:probeldev/niri-float-sticky";
    niri-screen-time.url = "github:probeldev/niri-screen-time";
    noctalia.url = "github:noctalia-dev/noctalia-shell/v4.7.7";

    steam-config-nix.url = "github:different-name/steam-config-nix";
    nixcord.url = "github:kaylorben/nixcord";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";

    nix-minecraft.url = "github:Infinidoge/nix-minecraft";

    stoney-kernel = {
      url = "github:chrultrabook/stoney-kernel";
      flake = false;
    };
  };
}
