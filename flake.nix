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

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    neovim.url = "github:9prestidigitator/nvim";

    nix-flatpak.url = "github:gmodena/nix-flatpak/latest";

    musnix.url = "github:musnix/musnix";
    audio-nix = {
      url = "github:polygon/audio.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri-blur-pr = {
      url = "github:niri-wm/niri?ref=pull/3483/head";
      flake = false;
    };
    niri-flake.url = "github:9prestidigitator/niri-flake";
    xwayland-satellite.url = "github:Supreeeme/xwayland-satellite";
    noctalia.url = "github:noctalia-dev/noctalia-shell/v4.7.5";

    caelestia-shell = {
      url = "github:caelestia-dots/shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    kwin-effects-forceblur = {
      url = "github:taj-ny/kwin-effects-forceblur";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    steam-config-nix.url = "github:different-name/steam-config-nix";
    nixcord.url = "github:kaylorben/nixcord";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";

    stoney-kernel = {
      url = "github:chrultrabook/stoney-kernel";
      flake = false;
    };

    nix-minecraft.url = "github:Infinidoge/nix-minecraft";
  };
}
