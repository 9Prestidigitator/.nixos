{
  inputs,
  self,
  ...
}: {
  flake.nixosConfigurations.iso = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = with self; [
      ({modulesPath, ...}: {imports = ["${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"];})

      nixosModules.terminal-tools
      nixosModules.mullvad

      nixosModules.ink-build-machine
      nixosModules.stylix

      nixosModules.keyd
      nixosModules.sops
      nixosModules.system-general
      nixosModules.home-manager
      nixosModules.nix

      nixosModules.iso
    ];
  };
}
