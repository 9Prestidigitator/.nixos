{self, ...}: {
  flake.nixosModules.vm = {
    host.name = "vm";
    home-manager = {
      users.max = {
        imports = with self.homeModules; [
          max

          neovim
          terminal-tools

          stylix

          essentials
        ];
      };
    };
  };
}
