{
  myLib,
  self,
  ...
}: {
  flake.nixosConfigurations.iso = myLib.mkNixosHost {
    modules = with self.nixosModules; [
      ({modulesPath, ...}: {imports = ["${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"];})

      terminal-tools
      mullvad

      ink-build-machine
      stylix

      keyd
      sops
      system-general
      nix

      ./_config.nix
    ];
  };
}
