{
  myLib,
  self,
  ...
}: {
  flake.nixosConfigurations.ink = myLib.mkNixosHost {
    modules = with self.nixosModules;
      [
        noctalia-greeter
        noctalia
        niri

        essentials
        brave-browser
        music-production
        design
        gaming
        media
        video-editing
        communications
        virtualisation
        ai

        mullvad
        syncthing
        keyd
        wine
        localsend

        sops
        stylix
        home-manager
        nix

        terminal-tools
        fonts
        tablet
        bluetooth
        grub
        nvidia
        system-general
      ]
      ++ (with self; [
        userModules.max.nixosModule

        ./_config.nix
        ./_fs.nix
        ./_hardware.nix
      ]);
  };
}
