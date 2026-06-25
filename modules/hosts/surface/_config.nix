{
  host.name = "surface";

  home-manager.users.max = {self, ...}: {
    imports = with self; [
      userModules.max.homeModule

      homeModules.gnome

      homeModules.neovim
      homeModules.terminal-tools

      homeModules.stylix
    ];
  };

  users.users.max.hashedPasswordFile = "/persist/passwds/max";
  users.users.max.openssh.authorizedKeys.keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAII00su22rL1ZJ59mb8+HVw21zft7IMLrd6yVvKd6f9Y2"];

  powerManagement.cpuFreqGovernor = "performance";
  services.displayManager.gdm.autoSuspend = false;

  systemd.sleep.settings.Sleep.AllowSuspend = "no";

  system.stateVersion = "26.05";
  home-manager.sharedModules = [{home.stateVersion = "26.05";}];
}
