{
  description = "Max's nix config";

  inputs = {
    nixpkgs_unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";

    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";

    musnix.url = "github:musnix/musnix";

    niri.url = "github:sodiboo/niri-flake";

    noctalia.url = "github:noctalia-dev/noctalia-shell";

    spicetify-nix.url = "github:Gerg-L/spicetify-nix";

    nixcord.url = "github:kaylorben/nixcord";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:nix-community/stylix/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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
      vm = mkHost "vm" "x86_64-linux" ["max"];
    };
  };
}
