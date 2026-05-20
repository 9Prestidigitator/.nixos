{
  inputs,
  self,
  ...
}: {
  flake.nixosConfigurations.ink = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = with self; [
      userModules.max.nixosModule
      userModules.guest.nixosModule

      nixosModules.ly
      nixosModules.niri
      nixosModules.noctalia

      nixosModules.essentials
      nixosModules.brave-browser
      nixosModules.music-production
      nixosModules.design
      nixosModules.gaming
      nixosModules.media
      nixosModules.video-editing
      nixosModules.communications
      nixosModules.virtualisation

      nixosModules.terminal-tools
      nixosModules.mullvad
      nixosModules.syncthing
      nixosModules.wine

      nixosModules.stylix
      nixosModules.fonts

      nixosModules.tablet
      nixosModules.keyd
      nixosModules.sops
      nixosModules.grub
      nixosModules.nvidia
      nixosModules.system-general
      nixosModules.home-manager
      nixosModules.nix

      nixosModules.ink
    ];
  };
}
