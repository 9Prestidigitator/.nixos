{lib, ...}: {
  host.name = "vm";

  home-manager.users.max = {self, ...}: {
    imports = with self; [
      userModules.max.homeModule

      homeModules.gnome

      homeModules.neovim
      homeModules.terminal-tools

      homeModules.bluetooth
      homeModules.stylix

      homeModules.essentials
    ];
  };
  users.users.max.hashedPasswordFile = "/persist/passwds/max";

  # Stuff nixos needs in a vm
  boot.loader = {
    efi = {
      canTouchEfiVariables = lib.mkForce false;
      efiSysMountPoint = "/boot";
    };
    grub.efiInstallAsRemovable = true;
  };

  system.stateVersion = "26.05";
  home-manager.sharedModules = [{home.stateVersion = "26.05";}];
}
