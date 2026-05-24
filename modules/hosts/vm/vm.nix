{self, inputs, ...}: {
  flake.nixosConfigurations.vm = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = with self; [
      userModules.max.nixosModule

      nixosModules.gnome

      nixosModules.essentials
      nixosModules.brave-browser

      nixosModules.terminal-tools

      nixosModules.ink-build-machine
      nixosModules.stylix
      nixosModules.fonts

      nixosModules.grub
      nixosModules.impermanence
      nixosModules.system-general
      nixosModules.home-manager
      nixosModules.nix

      inputs.disko.nixosModules.disko
      diskoConfigurations.vm
      ./_config.nix
      ./_hardware.nix
    ];
  };
}
