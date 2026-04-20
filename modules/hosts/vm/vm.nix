{
  inputs,
  self,
  ...
}: {
  imports = [inputs.home-manager.flakeModules.home-manager];
  flake = {
    nixosConfigurations.vm = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = with self.nixosModules; [
        max

        plasma

        essentials
        braveBrowser

        terminalTools

        stylix

        sops
        grub
        systemGeneral
        nix

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
        extraSpecialArgs = {
          inherit inputs;
          isLaptop = true;
        };
        users.max = {
          imports = with self.homeModules; [
            max

            neovim
            terminalTools

            stylix

            essentials
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
