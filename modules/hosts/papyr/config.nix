{self, ...}: {
  flake.nixosModules.papyr = {config, ...}: {
    host = {
      name = "papyr";
      isLaptop = true;
    };

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
          ink = {
            host = "ink";
            user = "max";
            hostname = "10.123.78.170";
            identityFile = config.sops.secrets."ssh/ink".path;
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

    users.users.max.openssh.authorizedKeys.keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOKWcs2PiK8MvDfOEadtln1NnnP3TYtdZUiY3Z8uov7u"];

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

    security = {
      pam.services.login.fprintAuth = true;
      pam.services.sudo.fprintAuth = true;
    };

    services = {
      blueman.enable = true;
      fprintd.enable = true;
    };

    hardware.cpu.intel.updateMicrocode = true;
  };
}
