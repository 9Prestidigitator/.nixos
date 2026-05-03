{self, ...}: {
  flake.nixosModules.papyr = {
    host = {
      name = "papyr";
      isLaptop = true;
    };
    system.stateVersion = "25.11";

    home-manager.users.max = {config, ...}: {
      home.stateVersion = "25.11";
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
        discord
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

    users.users.max.openssh.authorizedKeys.keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOKWcs2PiK8MvDfOEadtln1NnnP3TYtdZUiY3Z8uov7u"]; # ink->papyr

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
