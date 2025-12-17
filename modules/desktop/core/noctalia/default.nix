{
  lib,
  config,
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.noctalia.nixosModules.default
  ];

  config = lib.mkIf config.desktop.enable {

    services.noctalia-shell.enable = true;

    home-manager.sharedModules = [
      inputs.noctalia.homeModules.default
      ./settings.nix
      ./bar.nix
      ./dock.nix
    ];
  };
}
