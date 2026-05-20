{inputs, self, ...}: {
  flake.nixosConfigurations.book = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = with self; [
      userModules.max.nixosModule

      nixosModules.ly
      nixosModules.niri
      nixosModules.noctalia

      nixosModules.essentials
      nixosModules.brave-browser

      nixosModules.terminal-tools
      nixosModules.mullvad

      nixosModules.ink-build-machine
      nixosModules.stylix

      nixosModules.grub
      nixosModules.system-general
      nixosModules.home-manager
      nixosModules.nix

      diskoConfigurations.book
      hostModules.book
    ];
  };
}
