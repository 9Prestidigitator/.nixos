{inputs, ...}: {
  flake.nixosModules.umbriel = {pkgs, ...}: {
    imports = [inputs.umbriel.nixosModules.default];

    xdg.portal.enable = true;

    programs.umbriel = {
      enable = true;
      package = pkgs.umbriel;
      portalPackage = inputs.xdg-desktop-portal-umbriel.packages.${pkgs.stdenv.hostPlatform.system}.default;
    };
  };
}
