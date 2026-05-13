{inputs, self, ...}: {
  flake.nixosConfigurations.iso = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = with self.nixosModules; [
      "${inputs.nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"

      terminal-tools
      mullvad

      ink-build-machine
      stylix

      keyd
      system-general
      home-manager
      nix

      iso
    ];
  };
}
