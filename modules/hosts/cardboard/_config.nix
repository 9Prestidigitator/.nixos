{
  host.name = "cardboard";
  system.stateVersion = "25.11";

  home-manager.users.max = {self, ...}: {
    home.stateVersion = "25.11";
    imports = with self; [
      userModules.max.homeModule

      homeModules.neovim
      homeModules.terminal-tools

      homeModules.stylix

      homeModules.essentials
      homeModules.mpv
      homeModules.spicetify
      homeModules.discord
    ];
  };

  powerManagement.cpuFreqGovernor = "performance";
  services.blueman.enable = true;

  users.users.max.openssh.authorizedKeys.keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK7+7QTIxfPUGf8bYnZ8U/M7deNYriv6upTRsUtafdAA"];
}
