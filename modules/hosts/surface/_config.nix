{
  host.name = "surface";

  home-manager.users.max = {self, ...}: {
    imports = with self; [
      userModules.max.homeModule

      # homeModules.gnome
      homeModules.plasma

      homeModules.neovim
      homeModules.terminal-tools

      homeModules.stylix
    ];
  };

  users.users.max.openssh.authorizedKeys.keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAII00su22rL1ZJ59mb8+HVw21zft7IMLrd6yVvKd6f9Y2"];

  powerManagement.cpuFreqGovernor = "performance";
  services = {
    blueman.enable = true;
    displayManager.gdm.autoSuspend = false;
  };

  system.stateVersion = "25.11";
  home-manager.sharedModules = [{home.stateVersion = "25.11";}];
}
