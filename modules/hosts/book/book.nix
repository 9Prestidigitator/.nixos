{
  myLib,
  self,
  ...
}: {
  flake.nixosConfigurations.book = myLib.mkNixosHost {
    modules = with self; [
      userModules.max.nixosModule

      nixosModules.ly
      nixosModules.niri
      nixosModules.noctalia-5

      nixosModules.essentials
      nixosModules.brave-browser
      nixosModules.mullvad

      nixosModules.surface-build-machine
      nixosModules.ink-build-machine
      nixosModules.stylix
      nixosModules.btrfs-impermanence
      nixosModules.preservation
      nixosModules.home-manager
      nixosModules.nix

      nixosModules.terminal-tools
      nixosModules.fonts
      nixosModules.bluetooth
      nixosModules.grub
      nixosModules.chromebook-treeya
      nixosModules.system-general

      inputs.disko.nixosModules.disko
      diskoConfigurations.book
      ./_config.nix
      ./_hardware.nix
    ];
  };
}
