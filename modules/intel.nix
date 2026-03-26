{
  flake.nixosModules.intel = {pkgs, ...}: {
    hardware.graphics = {
      enable = true;
      extraPackages = with pkgs; [
        intel-media-driver
        intel-vaapi-driver
      ];
    };
    environment.sessionVariables = {
      LIBVA_DRIVER_NAME = "iHD";
    };
    services.thermald.enable = true;
  };
}
