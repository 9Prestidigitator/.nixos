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

      nixosModules.terminal-tools
      nixosModules.mullvad

      nixosModules.ink-build-machine
      nixosModules.stylix
      nixosModules.fonts

      nixosModules.sops
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
