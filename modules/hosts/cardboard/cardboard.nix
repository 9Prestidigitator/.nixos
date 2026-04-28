{inputs, self, ...}: {
  flake.nixosConfigurations.cardboard = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = with self.nixosModules; [
      max
      guest

      plasma

      essentials
      brave-browser
      design
      gaming
      media
      communications
      virtualisation

      terminal-tools
      mullvad

      ink-build-machine
      stylix
      fonts

      sops
      grub
      intel
      system-general
      home-manager
      nix

      cardboard
    ];
  };
}
