{
  description = "A very basic flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, home-manager, ... }:
      let
        system = "x86_64-linux";
      in {
        nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
	  inherit system;
          modules = [ 
	    ./configuration.nix

	    home-manager.nixosModules.home-manager
	    {
	      home-manager.useUserPackages = true;
	      home-manager.useGlobalPkgs = true;
	      home-manager.backupFileExtension = "backup";
	      home-manager.users.max = import ./home.nix;
	    }
	  ];
        };
      };
}
