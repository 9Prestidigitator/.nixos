{
  flake.nixosModules.intel = {pkgs, ...}: {
    hardware = {
      graphics = {
        enable = true;
        enable32Bit = true;
        extraPackages = with pkgs; [
          intel-media-driver
          intel-vaapi-driver
        ];
        extraPackages32 = with pkgs.pkgsi686Linux; [
          intel-vaapi-driver
        ];
      };
      cpu.intel.updateMicrocode = true;
    };
    environment.sessionVariables = {
      LIBVA_DRIVER_NAME = "iHD";
    };
    services.thermald.enable = true;
  };
}
