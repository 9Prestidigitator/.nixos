{
  description = "NixOS configuration for home systems.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:nix-community/stylix/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # rust patch not in main hardware branch yet
    # nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nixos-hardware.url = "github:8bitbuddhist/nixos-hardware?ref=surface-kernel-6.18";

    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";

    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";

    musnix.url = "github:musnix/musnix";
    audio-nix = {
      url = "github:polygon/audio.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri.url = "github:sodiboo/niri-flake";
    xwayland-satellite.url = "github:Supreeeme/xwayland-satellite";
    noctalia.url = "github:noctalia-dev/noctalia-shell";

    caelestia-shell = {
      url = "github:caelestia-dots/shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    kwin-effects-forceblur = {
      url = "github:taj-ny/kwin-effects-forceblur";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixcord.url = "github:kaylorben/nixcord";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";

    nix-minecraft.url = "github:Infinidoge/nix-minecraft";
  };

  outputs = {nixpkgs, ...} @ inputs: let
    lib = import ./lib {inherit inputs;};
  in {
    overlays.default = import ./pkgs;
    nixosModules = import ./pkgs/modules.nix;
    nixosConfigurations = lib.genHosts {
      ink = {users = ["max" "guest"];};
      papyr = {isLaptop = true;};
      surface = {isLaptop = true;};
      book = {isLaptop = true;};
      cardboard = {users = ["max" "guest"];};
      vm = {};
    };

    devShells = {
      default = import ./shells/default.nix {inherit nixpkgs;};
    };
  };
}
