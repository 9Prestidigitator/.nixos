{
  myLib,
  self,
  ...
}: {
  flake.nixosConfigurations.papyr = myLib.mkNixosHost {
    modules = with self.nixosModules; [
      self.userModules.max.nixosModule

      noctalia-greeter
      noctalia
      umbriel

      chromium
      music-production
      design
      gaming
      media
      communications
      virtualisation
      sunshine-moonlight
      ai

      gnome-keyring
      syncthing
      localsend
      mullvad
      uxplay
      flatpak
      fprintd
      wine
      wg0

      ink-build-machine
      stylix
      btrfs-rollback
      preservation
      home-manager
      nix

      terminal-tools
      tablet
      fonts
      keyd
      bluetooth
      grub
      intel
      system-general

      self.inputs.disko.nixosModules.disko
      self.diskoConfigurations.papyr
      ./_config.nix
      ./_hardware.nix
    ];
  };
}
