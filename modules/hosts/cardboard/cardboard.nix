{
  inputs,
  self,
  ...
}: {
  flake.nixosConfigurations.cardboard = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = with self; [
      userModules.max.nixosModule
      userModules.guest.nixosModule

      nixosModules.plasma

      nixosModules.essentials
      nixosModules.brave-browser
      nixosModules.design
      nixosModules.gaming
      nixosModules.media
      nixosModules.virtualisation

      nixosModules.terminal-tools
      nixosModules.mullvad

      nixosModules.ink-build-machine
      nixosModules.stylix
      nixosModules.fonts

      nixosModules.sops
      nixosModules.grub
      nixosModules.intel
      nixosModules.system-general
      nixosModules.home-manager
      nixosModules.nix

      hostModules.cardboard
    ];
  };
}
