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

      essentials
      brave-browser
      music-production
      design
      gaming
      media
      video-editing
      communications
      virtualisation
      ai

      mullvad
      syncthing
      keyd
      wine
      localsend

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
