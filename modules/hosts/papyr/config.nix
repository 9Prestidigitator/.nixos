{self, ...}: {
  flake.nixosModules.papyr = {
    host.name = "papyr";
    system.stateVersion = "25.11";

    home-manager.users.max = {config, ...}: {
      home.stateVersion = "25.11";
      imports = with self; [
        userModules.max.homeModule

        homeModules.niri
        homeModules.noctalia

        homeModules.neovim
        homeModules.terminal-tools
        homeModules.mpd

        homeModules.stylix

        homeModules.essentials
        homeModules.gaming
        homeModules.media
        homeModules.discord
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
