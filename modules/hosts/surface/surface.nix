{inputs, self, ...}: {
  flake.nixosConfigurations.surface = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = with self.nixosModules; [
      max

      gdm
      gnome

      essentials
      brave-browser

      terminal-tools
      minecraft-server

      ink-build-machine
      stylix

      keyd
      sops
      grub
      intel
      system-general
      home-manager
      nix

      surface

      inputs.nixos-hardware.nixosModules.microsoft-surface-common
    ];
  };
}
