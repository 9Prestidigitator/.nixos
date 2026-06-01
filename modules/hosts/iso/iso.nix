{
  myLib,
  self,
  ...
}: {
  flake.nixosConfigurations.iso = myLib.mkNixosHost {
    modules = with self; [
      ({modulesPath, ...}: {imports = ["${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"];})

      nixosModules.terminal-tools
      nixosModules.mullvad

      nixosModules.ink-build-machine
      nixosModules.stylix

      nixosModules.keyd
      nixosModules.sops
      nixosModules.system-general
      nixosModules.nix

      ./_config.nix
    ];
  };
}
