{inputs, self, ...}: {
  imports = [
    ./hardware.nix
    inputs.home-manager.flakeModules.home-manager
  ];
  flake = {
    nixosConfigurations.ink = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
        isLaptop = false;
      };
      modules = with self.nixosModules; [
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

        max
        guest

        stylix

        grub
        keyd
        tablet
        nvidia
        systemGeneral

        ink
      ];
    };

    nixosModules.ink = {pkgs, ...}: {
      networking = {
        hostName = "ink";
        networkmanager.enable = true;
      };

      imports = [inputs.home-manager.nixosModules.default];
      home-manager = {
        users.max = {
          import = with self.homeModules; [
            general
            neovim
            terminalTools
          ];
          home = {
            username = "max";
            homeDirectory = "/home/max";
            stateVersion = "25.11";
          };
        };
      };

      boot.kernelParams = ["threadirqs"];

      services = {
        blueman.enable = true;
        hardware.openrgb = {
          enable = true;
          package = pkgs.openrgb-with-all-plugins;
          motherboard = "amd";
        };
        logind = {
          settings.Login = {
            HandlePowerKey = "suspend";
          };
        };
      };

      powerManagement.cpuFreqGovernor = "performance";

      security = {
        polkit.enable = true;
        rtkit.enable = true;
      };

      fileSystems = {
        "/mnt/win" = {
          device = "/dev/disk/by-uuid/01DC699B1D247C50";
          fsType = "ntfs-3g";
          options = ["nofail" "uid=1000" "gid=100" "umask=022"];
        };
        "/mnt/1tb_ssd" = {
          device = "/dev/disk/by-uuid/78174bbc-f96b-4325-87b2-db3cebdf345c";
          fsType = "ext4";
          options = ["nofail" "defaults"];
        };
        "/mnt/1tb_hdd" = {
          device = "/dev/disk/by-uuid/7E90B7D790B7945D";
          fsType = "ntfs-3g";
          options = ["nofail" "uid=1000" "gid=100" "umask=022"];
        };
      };
    };
  };
}
