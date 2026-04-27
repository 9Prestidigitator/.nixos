{
  inputs,
  self,
  ...
}: {
  flake = {
    nixosConfigurations.cardboard = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = with self.nixosModules; [
        max
        guest

        plasma

        essentials
        brave-browser
        design
        gaming
        media
        communications
        virtualisation

        terminal-tools
        mullvad

        build-machines
        stylix
        fonts

        sops
        grub
        intel
        system-general
        home-manager
        nix

        cardboard
      ];
    };

    nixosModules.cardboard = {
      networking = {
        hostName = "cardboard";
        networkmanager.enable = true;
      };

      imports = [inputs.home-manager.nixosModules.default];
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
            media
            communications
          ];
          home = {
            username = "max";
            homeDirectory = "/home/max";
            stateVersion = "26.05";
          };
        };
      };

      powerManagement.cpuFreqGovernor = "performance";
      services.blueman.enable = true;

      users.users.max.openssh.authorizedKeys.keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK7+7QTIxfPUGf8bYnZ8U/M7deNYriv6upTRsUtafdAA"];
    };
  };
}
