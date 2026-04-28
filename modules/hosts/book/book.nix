{inputs, self, ...}: {
  flake.nixosConfigurations.book = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = with self.nixosModules; [
      max

      ly
      niri
      noctalia

      essentials
      brave-browser

      terminal-tools
      mullvad

      ink-build-machine
      stylix

      sops
      grub
      system-general
      home-manager
      nix

      book
    ];
  };
}
