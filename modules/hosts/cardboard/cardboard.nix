{
  myLib,
  self,
  ...
}: {
  flake.nixosConfigurations.cardboard = myLib.mkNixosHost {
    modules = with self; [
      userModules.max.nixosModule
      userModules.guest.nixosModule

      nixosModules.plasma

      nixosModules.essentials
      nixosModules.brave-browser
      nixosModules.design
      nixosModules.gaming
      nixosModules.media
      nixosModules.virtualisation

      nixosModules.mullvad
      nixosModules.uxplay

      nixosModules.surface-build-machine
      nixosModules.ink-build-machine
      nixosModules.stylix
      nixosModules.sops
      nixosModules.home-manager
      nixosModules.nix

      nixosModules.terminal-tools
      nixosModules.fonts
      nixosModules.bluetooth
      nixosModules.grub
      nixosModules.intel
      nixosModules.system-general

      ./_config.nix
      ./_hardware.nix
    ];
  };
}
