{
  inputs,
  self,
  ...
}: {
  flake = {
    nixosConfigurations.ink = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = with self.nixosModules; [
        max
        guest

        ly
        niri
        noctalia

        essentials
        brave-browser
        music-production
        design
        gaming
        media
        video-editing
        communications
        virtualisation

        terminal-tools
        mullvad
        syncthing
        wine

        stylix
        fonts

        tablet
        keyd
        sops
        grub
        nvidia
        system-general
        home-manager
        nix

        ink
      ];
    };

    nixosModules.ink = {pkgs, config, ...}: {
      host.name = "ink";

      home-manager = {
        users.max = {
          imports = with self.homeModules; [
            max

            niri
            noctalia

            neovim
            terminal-tools
            mpd

            stylix

            essentials
            gaming
            media
            communications
          ];

          programs.ssh.matchBlocks = {
            papyr = {
              host = "papyr";
              user = "max";
              hostname = "10.123.78.161";
              identityFile = config.sops.secrets."ssh/papyr".path;
              identitiesOnly = true;
            };
            surface = {
              host = "surface";
              user = "max";
              hostname = "10.123.78.31";
              identityFile = config.sops.secrets."ssh/surface".path;
              identitiesOnly = true;
            };
            cardboard = {
              host = "cardboard";
              user = "max";
              hostname = "10.123.78.156";
              identityFile = config.sops.secrets."ssh/cardboard".path;
              identitiesOnly = true;
            };
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

      users.users.max.openssh.authorizedKeys.keys = [
        # papyr->ink
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGYhcsf8FpAjdREk4TIAbugQlICIejGI8g+DLyAJ2ENi"
        # FONE->ink
        "ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBIE7a6cld/4ZWzzQT70YA/DWgt7lVf9NcWTqOdDi58onE8qrwjoH7PkmY8Ygd5HJQT0/a2jXPhnq7cCEHFtPCPk="
      ];

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
