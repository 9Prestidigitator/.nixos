{inputs, ...}: {
  flake.nixosModules.home-manager = {lib, config, ...}: {
    imports = [inputs.home-manager.nixosModules.default];

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      backupFileExtension = "backup";

      extraSpecialArgs = {
        inherit inputs;
        isLaptop = config.host.isLaptop;
      };
    };
  };
}
