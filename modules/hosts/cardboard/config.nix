{self, ...}: {
  flake.nixosModules.cardboard = {
    host = {
      name = "cardboard";
      isLaptop = true;
    };

    home-manager = {
      users.max = {
        imports = with self.homeModules; [
          max

          neovim
          terminal-tools

          stylix

          essentials
          media
          communications
        ];
      };
    };

    powerManagement.cpuFreqGovernor = "performance";
    services.blueman.enable = true;

    users.users.max.openssh.authorizedKeys.keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK7+7QTIxfPUGf8bYnZ8U/M7deNYriv6upTRsUtafdAA"];
  };
}
