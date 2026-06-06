{
  myLib,
  inputs,
  self,
  ...
}: {
  flake.nixosConfigurations.wsl = myLib.mkNixosHost {
    modules = with self; [
      inputs.nixos-wsl.nixosModules.default

      userModules.max.nixosModule

      nixosModules.media

      nixosModules.sops
      nixosModules.stylix
      nixosModules.home-manager
      nixosModules.nix

      nixosModules.terminal-tools
      nixosModules.system-general

      ./_config.nix
    ];
  };
}
