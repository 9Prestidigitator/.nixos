{inputs, self, ...}: {
  imports = [inputs.home-manager.flakeModules.home-manager];
  flake = {
    nixosConfigurations.vm = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = with self.nixosModules; [
        max

        niri

        essentials

        terminalTools

        stylix

        grub
        systemGeneral

        vm
      ];
    };
    nixosModules.vm = {
      networking = {
        hostName = "vm";
        networkmanager.enable = true;
      };

      imports = [inputs.home-manager.nixosModules.default];
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        backupFileExtension = "backup";
        extraSpecialArgs = {inherit inputs; isLaptop = true;};
        users.max = {
          imports = with self.homeModules; [
            max
            general
            neovim
            terminalTools
            desktop
          ];
          home = {
            username = "max";
            homeDirectory = "/home/max";
            stateVersion = "26.05";
          };
        };
      };
    };
  };
}
