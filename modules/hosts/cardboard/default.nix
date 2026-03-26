{
  inputs,
  self,
  ...
}: {
  flake = {
    nixosConfigurations.cardboard = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {isLaptop = true;};
      modules = with self.nixosModules; [
        max
        guest

        essentials
        braveBrowser
        design
        gaming
        media
        comms
        vm

        terminalTools
        mullvad

        buildMachines
        stylix

        grub
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
        users.max = {
          imports = with self.homeModules; [
            general
            neovim
            terminalTools
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
