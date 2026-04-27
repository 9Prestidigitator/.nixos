{
  inputs,
  self,
  ...
}: {
  flake = {
    nixosConfigurations.vm = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = with self.nixosModules; [
        max

        plasma

        essentials
        brave-browser

        terminal-tools

        stylix

        sops
        grub
        systemGeneral
        home-manager
        nix

        vm
      ];
    };
    nixosModules.vm = {
      networking = {
        hostName = "vm";
        networkmanager.enable = true;
      };

      home-manager = {
        extraSpecialArgs = {
          inherit inputs;
          isLaptop = true;
        };
        users.max = {
          imports = with self.homeModules; [
            max

            neovim
            terminal-tools

            stylix

            essentials
          ];
          home = {
            username = "max";
            homeDirectory = "/home/max";
            stateVersion = "26.05";
          };
        };
      };
    };
  };
}
