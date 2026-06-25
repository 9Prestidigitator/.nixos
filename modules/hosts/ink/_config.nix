{pkgs, ...}: {
  host.name = "ink";

  home-manager.users.max = {
    self,
    config,
    ...
  }: {
    imports = with self; [
      userModules.max.homeModule

      homeModules.noctalia
      homeModules.niri

      homeModules.neovim
      homeModules.terminal-tools
      homeModules.mpd
      homeModules.bluetooth

      homeModules.stylix

      homeModules.essentials
      homeModules.steam
      homeModules.reaper
      homeModules.mpv
      homeModules.spicetify
      homeModules.discord
    ];

    programs.ssh.settings = {
      papyr = {
        User = "max";
        HostName = "10.123.78.161";
        IdentityFile = config.sops.secrets."ssh/papyr".path;
        IdentitiesOnly = true;
      };
      surface = {
        User = "max";
        HostName = "10.123.78.31";
        IdentityFile = config.sops.secrets."ssh/surface".path;
        IdentitiesOnly = true;
      };
      cardboard = {
        User = "max";
        HostName = "10.123.78.156";
        IdentityFile = config.sops.secrets."ssh/cardboard".path;
        IdentitiesOnly = true;
      };
    };
  };

  users.users.max.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGYhcsf8FpAjdREk4TIAbugQlICIejGI8g+DLyAJ2ENi" # papyr->ink
    "ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBIE7a6cld/4ZWzzQT70YA/DWgt7lVf9NcWTqOdDi58onE8qrwjoH7PkmY8Ygd5HJQT0/a2jXPhnq7cCEHFtPCPk=" # FONE->ink
  ];

  hardware = {
    enableAllFirmware = true;
    cpu.amd.updateMicrocode = true;
  };
  powerManagement.cpuFreqGovernor = "performance";

  services.hardware.openrgb = {
    enable = true;
    package = pkgs.openrgb-with-all-plugins;
    motherboard = "amd";
  };

  services.flatpak.overrides."com.github.Matoking.protontricks".Context.filesystems = ["/mnt/1tb_ssd/SteamLibrary"];

  system.stateVersion = "25.11";
  home-manager.sharedModules = [{home.stateVersion = "25.11";}];
}
