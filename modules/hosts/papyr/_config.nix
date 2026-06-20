{
  host.name = "papyr";

  home-manager.users.max = {
    self,
    config,
    ...
  }: {
    imports = with self; [
      userModules.max.homeModule

      homeModules.niri
      homeModules.noctalia-5

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
      ink = {
        User = "max";
        HostName = "10.123.78.170";
        IdentityFile = config.sops.secrets."ssh/ink".path;
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

  users.users.max.hashedPasswordFile = "/persist/passwds/max";
  users.users.max.openssh.authorizedKeys.keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOKWcs2PiK8MvDfOEadtln1NnnP3TYtdZUiY3Z8uov7u"]; # ink->papyr

  system.stateVersion = "26.05";
  home-manager.sharedModules = [{home.stateVersion = "26.05";}];
}
