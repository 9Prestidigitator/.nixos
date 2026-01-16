{
  description = "Max's nix config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";

    nixpkgs-unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    # rust patch not in main hardware branch yet
    # nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nixos-hardware.url = "github:8bitbuddhist/nixos-hardware?ref=surface-rust-target-spec-fix";

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

    # yabridge menu patch not in main xwayland-satellite yet
    # xwayland-satellite.url = "github:Supreeeme/xwayland-satellite";
    xwayland-satellite.url = "github:GoranKovac/xwayland-satellite?ref=wmhints-popup-detection-yabridge";

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

    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {nixpkgs, ...} @ inputs: {
    overlays.default = import ./pkgs;
    nixosModules = import ./pkgs/modules.nix;
    nixosConfigurations = let
      mkHost = hostname: system: users:
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {inherit inputs hostname users;};
          modules = [
            ./hosts/${hostname}
            ./users
            inputs.home-manager.nixosModules.home-manager
            {
              home-manager = {
                useUserPackages = true;
                useGlobalPkgs = true;
                backupFileExtension = "backup";
                extraSpecialArgs = {inherit inputs hostname users;};
              };
            }
          ];
        };
    in {
      ink = mkHost "ink" "x86_64-linux" ["max" "guest"];
      papyr = mkHost "papyr" "x86_64-linux" ["max"];
      surface = mkHost "surface" "x86_64-linux" ["max"];
      book = mkHost "book" "x86_64-linux" ["max" "guest"];
      vm = mkHost "vm" "x86_64-linux" ["max"];
    };
  };
}
