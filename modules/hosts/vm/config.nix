{self, ...}: {
  flake.nixosModules.vm = {lib, ...}: {
    host.name = "vm";
    system.stateVersion = "25.11";

    home-manager.users.max = {
      home.stateVersion = "25.11";
      imports = with self; [
        userModules.max.homeModule

        homeModules.plasma

        homeModules.neovim
        homeModules.terminal-tools

        homeModules.stylix

        homeModules.essentials
      ];
    };

    users.users = {
      root.initialPassword = "nixos";
      max.initialPassword = "nixos";
    };

    boot.loader = {
      efi = {
        canTouchEfiVariables = lib.mkForce false;
        efiSysMountPoint = "/boot";
      };
      grub.efiInstallAsRemovable = true;
    };
  };
}
