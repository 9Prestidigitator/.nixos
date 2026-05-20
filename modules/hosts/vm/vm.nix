{ inputs, self, ... }: {
  flake.nixosConfigurations.vm = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = with self; [
      nixosModules.max

      nixosModules.plasma

      nixosModules.essentials
      nixosModules.brave-browser

      nixosModules.terminal-tools

      nixosModules.stylix

      nixosModules.grub
      nixosModules.system-general
      nixosModules.home-manager
      nixosModules.nix

      nixosModules.vm

      diskoConfigurations.vm
    ];
  };
}
