{self, inputs, ...}: {
  flake.nixosConfigurations.vm = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = with self; [
      userModules.max.nixosModule

      nixosModules.plasma

      nixosModules.essentials
      nixosModules.brave-browser

      nixosModules.ink-build-machine
      nixosModules.stylix
      nixosModules.impermanence
      nixosModules.home-manager
      nixosModules.nix

      nixosModules.terminal-tools
      nixosModules.fonts
      nixosModules.bluetooth
      nixosModules.grub
      nixosModules.system-general

      inputs.disko.nixosModules.disko
      diskoConfigurations.vm
      ./_config.nix
      ./_hardware.nix
    ];
  };
}
