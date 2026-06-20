{
  myLib,
  self,
  ...
}: {
  flake.nixosConfigurations.papyr = myLib.mkNixosHost {
    modules = with self; [
      userModules.max.nixosModule

      nixosModules.noctalia-greeter
      nixosModules.noctalia-5
      nixosModules.niri

      nixosModules.essentials
      nixosModules.brave-browser
      nixosModules.music-production
      nixosModules.design
      nixosModules.gaming
      nixosModules.media
      nixosModules.communications
      nixosModules.virtualisation

      nixosModules.mullvad
      nixosModules.syncthing
      nixosModules.wine
      nixosModules.wg0
      nixosModules.uxplay

      nixosModules.ink-build-machine
      nixosModules.stylix
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

      ./_config.nix
      ./_hardware.nix
    ];
  };
}
