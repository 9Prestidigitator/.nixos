{inputs, self, ...}: {
  flake.nixosConfigurations.ink = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = with self.nixosModules; [
      max
      guest

      ly
      niri
      noctalia

      essentials
      brave-browser
      music-production
      design
      gaming
      media
      video-editing
      communications
      virtualisation

      terminal-tools
      mullvad
      syncthing
      wine

      stylix
      fonts

      tablet
      keyd
      sops
      grub
      nvidia
      system-general
      home-manager
      nix

      ink
    ];
  };
}
