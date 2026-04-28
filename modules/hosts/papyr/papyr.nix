{inputs, self, ...}: {
  flake.nixosConfigurations.papyr = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = with self.nixosModules; [
      max

      ly
      niri
      noctalia

      essentials
      brave-browser
      music-production
      design
      gaming
      media
      communications
      virtualisation

      terminal-tools
      mullvad
      syncthing
      wine

      ink-build-machine
      stylix
      fonts

      tablet
      keyd
      sops
      grub
      intel
      system-general
      home-manager
      nix

      papyr
    ];
  };
}
