{
  host.name = "cardboard";

  home-manager.users = {
    max = {self, ...}: {
      imports = with self; [
        userModules.max.homeModule

        homeModules.plasma

        homeModules.essentials
        homeModules.terminal-tools
        homeModules.neovim
        homeModules.mpv
        homeModules.spotify
        homeModules.bluetooth

        homeModules.stylix
      ];
    };

    guest = {self, ...}: {
      imports = with self; [
        userModules.guest.homeModule

        homeModules.plasma

        homeModules.essentials
        homeModules.terminal-tools
        homeModules.neovim
        homeModules.mpv
        homeModules.spotify
        homeModules.discord
        homeModules.bluetooth

        homeModules.stylix
      ];
    };
  };

  users.users.max.openssh.authorizedKeys.keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK7+7QTIxfPUGf8bYnZ8U/M7deNYriv6upTRsUtafdAA"];

  systemd.sleep.settings.Sleep.AllowSuspend = "no";
  powerManagement.cpuFreqGovernor = "performance";

  services.uxplay.dynamicFirewall = false;

  system.stateVersion = "25.11";
  home-manager.sharedModules = [{home.stateVersion = "25.11";}];
}
