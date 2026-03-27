{inputs, ...}: {
  imports = [inputs.home-manager.flakeModules.home-manager];
  flake = {
    nixosConfigurations.papyr = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = with inputs.self.nixosModules; [
        max

        sddm
        niri

        essentials
        braveBrowser
        musicProduction
        design
        gaming
        media
        communications
        virtualisation

        terminalTools
        mullvad
        syncthing

        buildMachines
        stylix
        fonts

        tablet
        keyd
        grub
        intel
        systemGeneral

        papyr
      ];
    };

    nixosModules.papyr = {
      networking = {
        hostName = "papyr";
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
          imports = with inputs.self.homeModules; [
            max

            niri

            neovim
            terminalTools

            stylix

            essentials
            gaming
            media
            communications
          ];
          home = {
            username = "max";
            homeDirectory = "/home/max";
            stateVersion = "26.05";
          };
        };
      };

      hardware.cpu.intel.updateMicrocode = true;

      services = {
        blueman.enable = true;
        fprintd.enable = true;
      };

      security = {
        pam.services.login.fprintAuth = true;
        pam.services.sudo.fprintAuth = true;
      };

      networking.wg-quick.interfaces.wg0 = {
        configFile = "/secret/wg0.conf";
        autostart = false;
      };
    };
  };
}
