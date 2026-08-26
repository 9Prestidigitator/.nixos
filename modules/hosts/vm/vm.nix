{
  myLib,
  self,
  ...
}: {
  flake.nixosConfigurations.vm = myLib.mkNixosHost {
    modules = with self.nixosModules; [
      self.userModules.max.nixosModule

      plasma

      essentials
      chromium
      communications

      ink-build-machine
      stylix
      preservation
      home-manager
      nix

      terminal-tools
      fonts
      bluetooth
      grub
      system-general

      self.inputs.disko.nixosModules.disko
      self.diskoConfigurations.vm
      ./_config.nix
      ./_hardware.nix
    ];
  };
}
