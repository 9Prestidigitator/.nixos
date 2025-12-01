{
  description = "Max's nix config";

  inputs = {
    nixpkgs-unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri.url = "github:sodiboo/niri-flake";
    noctalia.url = "github:noctalia-dev/noctalia-shell";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {nixpkgs, ...} @ inputs: {
    nixosConfigurations = let
      username = "max";
      overlays = [inputs.neovim-nightly-overlay.overlays.default];
      specialArgs = {
        inherit inputs;
        inherit username;
        inherit overlays;
      };
    in {
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
    };
  };
}
