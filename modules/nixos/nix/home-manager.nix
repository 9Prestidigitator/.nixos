{
  inputs,
  self,
  ...
}: {
  flake.nixosModules.home-manager = {
    imports = [inputs.home-manager.nixosModules.default];
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      backupFileExtension = "backup";
      extraSpecialArgs = {inherit inputs self;};

      sharedModules = [self.homeModules.persistence];
    };
  };
}
