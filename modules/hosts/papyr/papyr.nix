{inputs, self, ...}: {
  flake.nixosConfigurations.papyr = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = with self; [
      userModules.max.nixosModule

      nixosModules.ly
      nixosModules.niri
      nixosModules.noctalia

      nixosModules.essentials
      nixosModules.brave-browser
      nixosModules.music-production
      nixosModules.design
      nixosModules.gaming
      nixosModules.media
      nixosModules.communications
      nixosModules.virtualisation

      nixosModules.terminal-tools
      nixosModules.mullvad
      nixosModules.syncthing
      nixosModules.wine

      nixosModules.ink-build-machine
      nixosModules.wg0
      nixosModules.stylix
      nixosModules.fonts

      nixosModules.tablet
      nixosModules.keyd
      nixosModules.bluetooth
      nixosModules.grub
      nixosModules.intel
      nixosModules.system-general
      nixosModules.home-manager
      nixosModules.nix

      ./_config.nix
      ./_hardware.nix
    ];
  };
}
