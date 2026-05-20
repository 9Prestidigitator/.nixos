{inputs, self, ...}: {
  flake.nixosConfigurations.surface = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = with self; [
      userModules.max.nixosModule

      nixosModules.gdm
      nixosModules.gnome

      nixosModules.essentials
      nixosModules.brave-browser

      nixosModules.terminal-tools
      nixosModules.minecraft-server
      # nixosModules.gitlab

      nixosModules.builder
      nixosModules.ink-build-machine
      nixosModules.stylix

      nixosModules.keyd
      nixosModules.grub
      nixosModules.intel
      nixosModules.system-general
      nixosModules.home-manager
      nixosModules.nix

      hostModules.surface
    ];
  };
}
