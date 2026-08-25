{inputs, ...}: {
  flake.nixosModules.umbriel = {pkgs, ...}: {
    imports = [inputs.umbriel.nixosModules.default];

    programs.umbriel = {
      enable = true;
      portalPackage = inputs.xdg-desktop-portal-umbriel.packages.${pkgs.stdenv.hostPlatform.system}.default;
    };
  };
}
