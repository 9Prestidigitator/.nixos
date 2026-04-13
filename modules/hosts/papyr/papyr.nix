{inputs, ...}: {
  imports = [inputs.home-manager.flakeModules.home-manager];
  flake = {
    nixosConfigurations.papyr = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = with inputs.self.nixosModules; [
        max

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

        buildMachines
        stylix
        fonts

        tablet
        keyd
        sops
        grub
        intel
        systemGeneral
        nix

        papyr
      ];
    };

    nixosModules.papyr = {config, ...}: {
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

      users.users.max.openssh.authorizedKeys.keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOKWcs2PiK8MvDfOEadtln1NnnP3TYtdZUiY3Z8uov7u"];
      programs.ssh.extraConfig = ''
        Host ink
          HostName 10.123.78.170
          User max
          IdentityFile ${config.sops.secrets."ssh/ink".path}
          IdentitiesOnly yes
        Host surface
          HostName 10.123.78.31
          User max
          IdentityFile ${config.sops.secrets."ssh/surface".path}
          IdentitiesOnly yes
      '';

      networking.wg-quick.interfaces.wg0 = {
        autostart = false;
        address = ["10.177.136.3/24"];
        dns = ["1.1.1.1" "1.0.0.1"];
        privateKeyFile = "${config.sops.secrets."wg0/interface-key".path}";
        peers = [
          {
            publicKey = "v0fbXMD0qSknF/lxTGf0iY0xs1ffm1Fm6igknJQKi10=";
            presharedKeyFile = "${config.sops.secrets."wg0/peer-key".path}";
            endpoint = "108.18.94.91:51820";
            allowedIPs = ["0.0.0.0/0"];
          }
        ];
      };
    };
  };
}
