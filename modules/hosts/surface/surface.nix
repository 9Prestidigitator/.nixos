{
  myLib,
  self,
  ...
}: {
  flake.nixosConfigurations.surface = myLib.mkNixosHost {
    modules = with self; [
      userModules.max.nixosModule

      nixosModules.gdm
      nixosModules.gnome

      nixosModules.essentials
      nixosModules.brave-browser

      nixosModules.keyd
      nixosModules.minecraft-server
      nixosModules.uxplay
      # nixosModules.gitlab

      nixosModules.builder
      nixosModules.ink-build-machine
      nixosModules.stylix
      nixosModules.btrfs-rollback
      nixosModules.preservation
      nixosModules.home-manager
      nixosModules.nix

      nixosModules.terminal-tools
      nixosModules.fonts
      nixosModules.grub
      nixosModules.intel
      nixosModules.surface-6
      nixosModules.system-general

      inputs.disko.nixosModules.disko
      diskoConfigurations.surface
      ./_config.nix
      ./_hardware.nix
    ];
  };
}
