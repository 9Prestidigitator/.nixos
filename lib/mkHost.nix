{
  nixpkgs,
  inputs,
  ...
}: {
  hostname,
  system ? "x86_64-linux",
  users,
  isLaptop ? false,
}:
nixpkgs.lib.nixosSystem {
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
}
