{self, inputs, ...}: {
  flake.nixosConfigurations.book = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = with self; [
      userModules.max.nixosModule

      nixosModules.ly
      nixosModules.niri
      nixosModules.noctalia-5

      nixosModules.essentials
      nixosModules.brave-browser

      nixosModules.terminal-tools
      nixosModules.mullvad

      nixosModules.ink-build-machine
      nixosModules.stylix
      nixosModules.fonts

      nixosModules.grub
      nixosModules.impermanence
      nixosModules.system-general
      nixosModules.home-manager
      nixosModules.nix

      inputs.disko.nixosModules.disko
      diskoConfigurations.book
      hostModules.book
    ];
  };
}
