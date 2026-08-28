{
  myLib,
  self,
  ...
}: {
  flake.nixosConfigurations.book = myLib.mkNixosHost {
    modules = with self.nixosModules; [
      self.userModules.max.nixosModule

      noctalia-greeter
      noctalia
      niri

      chromium
      mullvad
      sunshine-moonlight

      gnome-keyring

      ink-build-machine
      surface-build-machine
      stylix
      btrfs-rollback
      preservation
      home-manager
      nix

      terminal-tools
      fonts
      bluetooth
      grub
      chromebook-treeya
      system-general

      self.inputs.disko.nixosModules.disko
      self.diskoConfigurations.book
      ./_config.nix
      ./_hardware.nix
    ];
  };
}
