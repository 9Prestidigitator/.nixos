{self, ...}: {
  flake.nixosModules.ink = {pkgs, ...}: {
    host.name = "ink";
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

    users.users.max.openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGYhcsf8FpAjdREk4TIAbugQlICIejGI8g+DLyAJ2ENi" # papyr->ink
      "ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBIE7a6cld/4ZWzzQT70YA/DWgt7lVf9NcWTqOdDi58onE8qrwjoH7PkmY8Ygd5HJQT0/a2jXPhnq7cCEHFtPCPk=" # FONE->ink
    ];

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

    services.flatpak.overrides."com.github.Matoking.protontricks".Context.filesystems = ["/mnt/1tb_ssd/SteamLibrary"];
  };
}
