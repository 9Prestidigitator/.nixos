{
  description = "Max's nix config";

  inputs = {
    nixpkgs-unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    musnix.url = "github:musnix/musnix";
    niri.url = "github:sodiboo/niri-flake";
    noctalia.url = "github:noctalia-dev/noctalia-shell";
    flake-utils.url = "github:numtide/flake-utils";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    nixcord.url = "github:kaylorben/nixcord";
    native-access-nix.url = "github:yusefnapora/native-access-nix";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:nix-community/stylix/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {nixpkgs, ...} @ inputs: {
    nixosConfigurations = let
      username = "max";
      specialArgs = {
        inherit inputs;
        inherit username;
      };
    in {
      ink = nixpkgs.lib.nixosSystem {
        inherit specialArgs;
        modules = [
          ./hosts/ink
          ./users/${username}/nixos.nix
          inputs.home-manager.nixosModules.home-manager
          {
            home-manager.useUserPackages = true;
            home-manager.useGlobalPkgs = true;
            home-manager.backupFileExtension = "backup";
            home-manager.extraSpecialArgs = {
              inherit inputs;
              inherit username;
            };
            home-manager.users.${username} = import ./users/${username}/home.nix;
          }
        ];
      };
      KingSpec = nixpkgs.lib.nixosSystem {
        inherit specialArgs;
        modules = [
          ./hosts/KingSpec
          ./users/${username}/nixos.nix
          inputs.home-manager.nixosModules.home-manager
          {
            home-manager.useUserPackages = true;
            home-manager.useGlobalPkgs = true;
            home-manager.backupFileExtension = "backup";
            home-manager.extraSpecialArgs = {
              inherit inputs;
              inherit username;
            };
            home-manager.users.${username} = import ./users/${username}/home.nix;
          }
        ];
      };
      vm = nixpkgs.lib.nixosSystem {
        inherit specialArgs;
        modules = [
          ./hosts/vm
          ./users/${username}/nixos.nix
          inputs.home-manager.nixosModules.home-manager
          {
            home-manager.useUserPackages = true;
            home-manager.useGlobalPkgs = true;
            home-manager.backupFileExtension = "backup";
            home-manager.extraSpecialArgs = {
              inherit inputs;
              inherit username;
            };
            home-manager.users.${username} = import ./users/${username}/home.nix;
          }
        ];
      };
    };
  };
}
