{
  myLib,
  self,
  ...
}: {
  flake.nixosConfigurations.ink = myLib.mkNixosHost {
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
      nixosModules.keyd
      nixosModules.wine
      nixosModules.localsend

      nixosModules.sops
      nixosModules.stylix
      nixosModules.home-manager
      nixosModules.nix

      nixosModules.terminal-tools
      nixosModules.fonts
      nixosModules.tablet
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
