{
  pkgs,
  lib,
  ...
}: {
  host.name = "wsl";
  home-manager.users.max = {self, ...}: {
    imports = with self; [
      userModules.max.homeModule

      homeModules.neovim
      homeModules.terminal-tools

      homeModules.stylix

      homeModules.essentials
    ];
  };

  wsl = {
    enable = true;
    defaultUser = "max";
    startMenuLaunchers = true;
  };

  networking = {
    networkmanager.enable = lib.mkForce false;
    # useDHCP = lib.mkForce false;
  };

  environment.systemPackages = with pkgs; [usbutils kmod cryptsetup];

  system.stateVersion = "26.05";
  home-manager.sharedModules = [{home.stateVersion = "26.05";}];
}
