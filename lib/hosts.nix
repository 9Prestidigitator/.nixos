{inputs, ...}: let
  mkHost = hostname: {
    system ? "x86_64-linux",
    users ? ["max"],
    isLaptop ? false,
  }:
    inputs.nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {inherit inputs hostname users isLaptop;};
      modules = [
        ../hosts/${hostname}
        ../users
        inputs.home-manager.nixosModules.home-manager
        {
          home-manager = {
            useUserPackages = true;
            useGlobalPkgs = true;
            backupFileExtension = "backup";
            extraSpecialArgs = {inherit inputs hostname users isLaptop;};
          };
        }
      ];
    };
in {
  mkHost = mkHost;
  genHosts = builtins.mapAttrs mkHost;
}
