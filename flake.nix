{
  description = "flake";

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
    niri.url = "github:sodiboo/niri-flake";
    noctalia.url = "github:noctalia-dev/noctalia-shell";
  };

  outputs = {nixpkgs, ...} @ inputs: {
    nixosConfigurations = {
      nixos = let
        system = "x86_64-linux";
        username = "max";
        overlays = [inputs.neovim-nightly-overlay.overlays.default];
        specialArgs = {inherit username;};
      in
        nixpkgs.lib.nixosSystem {
          inherit specialArgs;

          modules = [
            /home/max/.nixos/hosts/vm
            /home/max/.nixos/users/${username}/nixos.nix
            {nixpkgs.overlays = overlays;}
            {
              environment.systemPackages = [
                inputs.quickshell.packages.x86_64-linux.default
                nixpkgs.legacyPackages.${system}.qt6.qtdeclarative
              ];
            }
            inputs.home-manager.nixosModules.home-manager
            {
              home-manager.useUserPackages = true;
              home-manager.useGlobalPkgs = true;
              home-manager.backupFileExtension = "backup";
              home-manager.extraSpecialArgs = {inherit inputs;};
              home-manager.users.${username} = import /home/max/.nixos/users/${username}/home.nix;
            }
          ];
        };
    };
  };
}
