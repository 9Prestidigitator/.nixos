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

      essentials
      brave-browser
      music-production
      design
      gaming
      media
      communications
      virtualisation
      ai

      mullvad
      syncthing
      wine
      wg0
      uxplay
      localsend
      fprintd

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
