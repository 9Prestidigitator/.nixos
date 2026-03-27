{inputs, self, ...}: {
  imports = [inputs.home-manager.flakeModules.home-manager];
  flake = {
    nixosConfigurations.cardboard = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = with self.nixosModules; [
        max
        guest

        plasma

        essentials
        braveBrowser
        design
        gaming
        media
        communications
        virtualisation

        terminalTools
        mullvad

        buildMachines
        stylix
        fonts

        grub
        intel
        systemGeneral

        cardboard
      ];
    };

    nixosModules.cardboard = {
      networking = {
        hostName = "cardboard";
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
            
            niri

            neovim
            terminalTools

            stylix
          ];
          home = {
            username = "max";
            homeDirectory = "/home/max";
            stateVersion = "26.05";
          };
        };
      };

      powerManagement.cpuFreqGovernor = "performance";
      services.blueman.enable = true;
    };
  };
}
