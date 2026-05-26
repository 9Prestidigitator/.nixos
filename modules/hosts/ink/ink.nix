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

      nixosModules.mullvad
      nixosModules.syncthing
      nixosModules.wine

      nixosModules.sops
      nixosModules.stylix
      nixosModules.home-manager
      nixosModules.nix

      nixosModules.terminal-tools
      nixosModules.fonts
      nixosModules.tablet
      nixosModules.keyd
      nixosModules.bluetooth
      nixosModules.grub
      nixosModules.nvidia
      nixosModules.system-general

      ./_config.nix
      ./_fs.nix
      ./_hardware.nix
    ];
  };
}
