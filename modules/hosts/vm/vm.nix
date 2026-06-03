{
  myLib,
  self,
  ...
}: {
  flake.nixosConfigurations.vm = myLib.mkNixosHost {
    modules = with self; [
      userModules.max.nixosModule

      nixosModules.plasma

      nixosModules.essentials
      nixosModules.brave-browser
      nixosModules.communications

      nixosModules.ink-build-machine
      nixosModules.stylix
      nixosModules.preservation
      nixosModules.home-manager
      nixosModules.nix

      nixosModules.terminal-tools
      nixosModules.fonts
      nixosModules.bluetooth
      nixosModules.grub
      nixosModules.system-general

      inputs.disko.nixosModules.disko
      diskoConfigurations.vm
      ./_config.nix
      ./_hardware.nix
    ];
  };
}
