{
  myLib,
  self,
  ...
}: {
  flake.nixosConfigurations.ink = myLib.mkNixosHost {
    modules = with self.nixosModules; [
      self.userModules.max.nixosModule

      noctalia-greeter
      noctalia
      niri

      chromium
      music-production
      design
      gaming
      media
      video-editing
      communications
      virtualisation
      sunshine-moonlight
      ai

      gnome-keyring
      syncthing
      localsend
      mullvad
      flatpak
      keyd
      wine

      sops
      stylix
      home-manager
      nix

      terminal-tools
      fonts
      tablet
      bluetooth
      grub
      nvidia
      system-general

      ./_config.nix
      ./_fs.nix
      ./_hardware.nix
    ];
  };
}
