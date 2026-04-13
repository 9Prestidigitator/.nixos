{
  inputs,
  self,
  ...
}: {
  imports = [inputs.home-manager.flakeModules.home-manager];
  flake = {
    nixosConfigurations.ink = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = with self.nixosModules; [
        max
        guest

        ly
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

        stylix
        fonts

        tablet
        keyd
        sops
        grub
        nvidia
        systemGeneral
        nix

        ink
      ];
    };

    nixosModules.ink = {pkgs, config, ...}: {
      networking = {
        hostName = "ink";
        networkmanager.enable = true;
      };

      imports = [inputs.home-manager.nixosModules.default];
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        backupFileExtension = "backup";
        extraSpecialArgs = {
          inherit inputs;
          isLaptop = false;
        };
        users.max = {
          imports = with self.homeModules; [
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

      boot.kernelParams = ["threadirqs"];
      hardware = {
        enableAllFirmware = true;
        cpu.amd.updateMicrocode = true;
      };

      powerManagement.cpuFreqGovernor = "performance";

      services = {
        blueman.enable = true;
        hardware.openrgb = {
          enable = true;
          package = pkgs.openrgb-with-all-plugins;
          motherboard = "amd";
        };
      };

      users.users.max.openssh.authorizedKeys.keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGYhcsf8FpAjdREk4TIAbugQlICIejGI8g+DLyAJ2ENi"];
      programs.ssh.extraConfig = ''
        HostName papyr
          HostName 10.123.78.161
          User max
          IdentityFile ${config.sops.secrets."ssh/papyr".path}
          IdentitiesOnly yes
      '';

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
