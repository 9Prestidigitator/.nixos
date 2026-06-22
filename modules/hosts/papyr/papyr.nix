{
  myLib,
  self,
  ...
}: {
  flake.nixosConfigurations.papyr = myLib.mkNixosHost {
    modules = with self; [
      userModules.max.nixosModule

      nixosModules.plasma

      nixosModules.essentials
      nixosModules.brave-browser
      nixosModules.music-production
      nixosModules.design
      nixosModules.gaming
      nixosModules.media
      nixosModules.communications
      nixosModules.virtualisation
      nixosModules.ai

      nixosModules.mullvad
      nixosModules.syncthing
      nixosModules.wine
      nixosModules.wg0
      nixosModules.uxplay
      nixosModules.fprintd

      nixosModules.ink-build-machine
      nixosModules.stylix
      nixosModules.btrfs-rollback
      nixosModules.preservation
      nixosModules.home-manager
      nixosModules.nix

      nixosModules.terminal-tools
      nixosModules.tablet
      nixosModules.fonts
      nixosModules.keyd
      nixosModules.bluetooth
      nixosModules.grub
      nixosModules.intel
      nixosModules.system-general

      inputs.disko.nixosModules.disko
      diskoConfigurations.papyr
      ./_config.nix
      ./_hardware.nix
    ];
  };
}
