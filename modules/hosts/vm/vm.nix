{self, inputs, ...}: {
  flake.nixosConfigurations.vm = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = with self; [
      userModules.max.nixosModule

      nixosModules.plasma

      nixosModules.essentials
      nixosModules.brave-browser

      nixosModules.terminal-tools

      nixosModules.stylix

      nixosModules.grub
      nixosModules.impermanence
      nixosModules.system-general
      nixosModules.home-manager
      nixosModules.nix

      hostModules.vm
      diskoConfigurations.vm
    ];
  };
}
