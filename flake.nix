{
	description = "A very basic flake";
	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		nvim-config = {
			url = "github:/9Prestidigitator/nvim";
			flake = false;
		};
		neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
	};
	outputs = { self, nixpkgs, home-manager, nvim-config, ... }@inputs: let
		system = "x86_64-linux";
		pkgs = nixpkgs.legacyPackages.${system};
		overlays = [
			inputs.neovim-nightly-overlay.overlays.default
		];
	in {
		nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
			inherit system;
			inherit pkgs;
			modules = [ 
				./configuration.nix
                { nixpkgs.overlays = overlays; }
				home-manager.nixosModules.home-manager
				{
					home-manager.useUserPackages = true;
					home-manager.useGlobalPkgs = true;
					home-manager.backupFileExtension = "backup"; home-manager.extraSpecialArgs = {
                        inherit inputs;
						inherit nvim-config;
					};
					home-manager.users.max = import ./home.nix;
				}
			];
		};
	};
}
