{
  nixpkgs,
  inputs,
  ...
}: hostname: system: users:
nixpkgs.lib.nixosSystem {
  inherit system;
  specialArgs = {inherit inputs hostname users;};
  modules = [
    ../hosts/${hostname}
    ../users
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
}
