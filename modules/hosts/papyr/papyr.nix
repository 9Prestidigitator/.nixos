{
  myLib,
  self,
  ...
}: {
  flake.nixosConfigurations.papyr = myLib.mkNixosHost {
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
        communications
        virtualisation
        ai

        mullvad
        syncthing
        wine
        wg0
        uxplay
        localsend
        fprintd

        ink-build-machine
        stylix
        btrfs-rollback
        preservation
        home-manager
        nix

        terminal-tools
        tablet
        fonts
        keyd
        bluetooth
        grub
        intel
        system-general
      ]
      ++ (with self; [
        userModules.max.nixosModule

        inputs.disko.nixosModules.disko
        diskoConfigurations.papyr
        ./_config.nix
        ./_hardware.nix
      ]);
  };
}
