{
  inputs,
  self,
  ...
}: {
  flake.nixosConfigurations.surface = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = with self; [
      userModules.max.nixosModule

      nixosModules.gdm
      nixosModules.gnome

      nixosModules.essentials
      nixosModules.brave-browser

      nixosModules.keyd
      nixosModules.minecraft-server
      # nixosModules.gitlab

      nixosModules.builder
      nixosModules.ink-build-machine
      nixosModules.stylix
      nixosModules.home-manager
      nixosModules.nix

      nixosModules.terminal-tools
      nixosModules.fonts
      nixosModules.grub
      nixosModules.intel
      nixosModules.surface-6
      nixosModules.system-general

      ./_config.nix
      ./_hardware.nix
    ];
  };
}
