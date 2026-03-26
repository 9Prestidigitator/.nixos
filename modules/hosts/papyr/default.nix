{inputs, self, ...}: {
  imports = [inputs.home-manager.flakeModules.home-manager];
  flake = {
    nixosConfigurations.papyr = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {isLaptop = true;};
      modules = with self.nixosModules; [
        max

        niri

        essentials
        braveBrowser
        musicProduction
        design
        gaming
        media
        comms
        vm

        terminalTools
        mullvad

        buildMachines
        stylix

        tablet
        keyd
        grub
        nvidia
        systemGeneral

        papyr
      ];
    };

    nixosModules.papyr = {pkgs, ...}: {
      networking.hostName = "papyr";
      networking.networkmanager.enable = true;

      hardware.graphics = {
        enable = true;
        extraPackages = with pkgs; [
          intel-media-driver
          intel-vaapi-driver
        ];
      };
      environment.sessionVariables = {
        LIBVA_DRIVER_NAME = "iHD";
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

      boot.kernelParams = ["threadirqs"];

      services = {
        thermald.enable = true;
        blueman.enable = true;
        fprintd.enable = true;
        logind = {
          settings.Login = {
            HandleLidSwitch = "suspend";
            HandleLidSwitchDocked = "ignore";
            HandlePowerKey = "suspend";
          };
        };
      };

      security = {
        pam.services.login.fprintAuth = true;
        pam.services.sudo.fprintAuth = true;
        polkit.enable = true;
        rtkit.enable = true;
      };

      networking.wg-quick.interfaces.wg0 = {
        configFile = "/secret/wg0.conf";
        autostart = false;
      };
    };
  };
}
