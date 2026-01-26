{
  description = "NixOS configuration for home systems.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";

    nixpkgs-unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    # rust patch not in main hardware branch yet
    # nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nixos-hardware.url = "github:8bitbuddhist/nixos-hardware?ref=surface-kernel-6.18";
    # nixos-hardware.url = "github:8bitbuddhist/nixos-hardware?ref=surface-rust-target-spec-fix";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";

    stylix = {
      url = "github:nix-community/stylix/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";

    musnix.url = "github:musnix/musnix";

    audio-nix = {
      url = "github:polygon/audio.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri.url = "github:sodiboo/niri-flake";

    noctalia.url = "github:noctalia-dev/noctalia-shell";

    xwayland-satellite.url = "github:Supreeeme/xwayland-satellite";
    # Tying to particular commit I like bc latest is unstable
    # xwayland-satellite.url = "github:Supreeeme/xwayland-satellite/ed1cef792b4def3321ff9ab5479df09609f17a69";

    caelestia-shell = {
      url = "github:caelestia-dots/shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    kwin-effects-forceblur = {
      url = "github:taj-ny/kwin-effects-forceblur";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix.url = "github:Gerg-L/spicetify-nix";

    nixcord.url = "github:kaylorben/nixcord";

    tablet-mode.url = "git+https://destiny.ostylk.de/gitea/NixDistro/tablet-mode.git";

    nix-minecraft.url = "github:Infinidoge/nix-minecraft";
  };

  outputs = {nixpkgs, ...} @ inputs: let
    mkHost = import ./lib/mkHost.nix {inherit nixpkgs inputs;};
  in {
    overlays.default = import ./pkgs;
    nixosModules = import ./pkgs/modules.nix;
    nixosConfigurations = {
      ink = mkHost {
        hostname = "ink";
        users = ["max" "guest"];
      };
      papyr = mkHost {
        hostname = "papyr";
        users = ["max"];
        isLaptop = true;
      };
      surface = mkHost {
        hostname = "surface";
        users = ["max"];
        isLaptop = true;
      };
      book = mkHost {
        hostname = "book";
        users = ["max" "guest"];
        isLaptop = true;
      };
      vm = mkHost {
        hostname = "vm";
        users = ["max"];
      };
    };
  };
}
