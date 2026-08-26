{
  myLib,
  self,
  ...
}: {
  flake.nixosConfigurations.cardboard = myLib.mkNixosHost {
    modules = with self.nixosModules; [
      self.userModules.max.nixosModule
      self.userModules.guest.nixosModule

      plasma

      essentials
      chromium
      design
      gaming
      media
      virtualisation
      sunshine-moonlight

      mullvad
      uxplay

      surface-build-machine
      ink-build-machine
      stylix
      sops
      home-manager
      nix

      terminal-tools
      fonts
      bluetooth
      grub
      intel
      system-general

      ./_config.nix
      ./_hardware.nix
    ];
  };
}
