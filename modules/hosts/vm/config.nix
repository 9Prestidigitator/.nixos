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
  };
}
