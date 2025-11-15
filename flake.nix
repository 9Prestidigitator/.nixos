{
  description = "A very basic flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = {nixpkgs, ...} @ inputs: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    overlays = [inputs.neovim-nightly-overlay.overlays.default];
  in {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      inherit system;
      inherit pkgs;
      modules = [
        ./configuration.nix
        {nixpkgs.overlays = overlays;}
        {
          environment.systemPackages = [
            inputs.quickshell.packages.x86_64-linux.default
            pkgs.qt6.qtdeclarative
          ];
        }
        inputs.home-manager.nixosModules.home-manager
        {
          home-manager.useUserPackages = true;
          home-manager.useGlobalPkgs = true;
          home-manager.backupFileExtension = "backup";
          home-manager.extraSpecialArgs = {inherit inputs;};
          home-manager.users.max = import ./home.nix;
        }
      ];
    };
  };
}
