{
  myLib,
  self,
  ...
}: {
  flake.nixosConfigurations.surface = myLib.mkNixosHost {
    modules = with self.nixosModules; [
      self.userModules.max.nixosModule

      gdm
      gnome

      essentials
      brave-browser

      keyd
      minecraft-server
      uxplay
      # gitlab

      builder
      ink-build-machine
      stylix
      btrfs-rollback
      preservation
      home-manager
      nix

      terminal-tools
      fonts
      grub
      intel
      surface-6
      system-general

      self.inputs.disko.nixosModules.disko
      self.diskoConfigurations.surface
      ./_config.nix
      ./_hardware.nix
    ];
  };
}
