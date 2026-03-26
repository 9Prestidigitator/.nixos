{inputs, ...}: {
  perSystem = {pkgs, ...}: {
    packages.overwitch = pkgs.callPackage ../packages/overwitch.nix {};
  };

  flake.overlays.default = final: prev: {
    overwitch = final.callPackage ../packages/overwitch.nix {};
  };

  flake.nixosModules.overwitch = {pkgs, ...}: {
    environment.systemPackages = [pkgs.overwitch];

    services.udev.packages = [pkgs.overwitch];
  };
}
