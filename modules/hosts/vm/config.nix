{self, ...}: {
  flake.nixosModules.vm = {
    host.name = "vm";
    system.stateVersion = "25.11";

    home-manager.users.max = {
      home.stateVersion = "25.11";
      imports = with self.homeModules; [
        max

        neovim
        terminal-tools

        stylix

        essentials
      ];
    };

    users.users = {
      root.initialPassword = "nixos";
      max.initialPassword = "nixos";
    };

    boot.loader = {
      efi = {
        canTouchEfiVariables = false;
        efiSysMountPoint = "/boot";
      };
      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
        efiInstallAsRemovable = true;
        useOSProber = false;
      };
    };
  };
}
