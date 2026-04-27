{
  inputs,
  self,
  ...
}: {
  flake = {
    nixosConfigurations.papyr = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = with self.nixosModules; [
        max

        ly
        niri

        essentials
        brave-browser
        music-production
        design
        gaming
        media
        communications
        virtualisation

        terminal-tools
        mullvad
        syncthing
        wine

        buildMachines
        stylix
        fonts

        tablet
        keyd
        sops
        grub
        intel
        systemGeneral
        home-manager
        nix

        papyr
      ];
    };

    nixosModules.papyr = {config, ...}: {
      networking = {
        hostName = "papyr";
        networkmanager.enable = true;
      };

      home-manager = {
        extraSpecialArgs = {
          inherit inputs;
          isLaptop = true;
        };
        users.max = {
          imports = with self.homeModules; [
            max

            niri

            neovim
            terminal-tools

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
        Host cardboard
          HostName 10.123.78.156
          User max
          IdentityFile ${config.sops.secrets."ssh/cardboard".path}
          IdentitiesOnly yes
      '';

      networking.wg-quick.interfaces.wg0 = {
        autostart = false;
        address = ["10.177.136.3/24"];
        dns = ["1.1.1.1" "1.0.0.1"];
        privateKeyFile = "${config.sops.secrets."wg0/private-key".path}";
        peers = [
          {
            publicKey = "v0fbXMD0qSknF/lxTGf0iY0xs1ffm1Fm6igknJQKi10=";
            presharedKeyFile = "${config.sops.secrets."wg0/peer-preshared-key".path}";
            endpoint = "108.18.94.91:51820";
            allowedIPs = ["0.0.0.0/0"];
            persistentKeepalive = 25;
          }
        ];
      };
    };
  };
}
