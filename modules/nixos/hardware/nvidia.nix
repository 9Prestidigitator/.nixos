{
  flake.nixosModules.nvidia = {
    hardware = {
      graphics.enable = true;
      nvidia = {
        modesetting.enable = true;
        open = false;
        powerManagement = {
          enable = true;
          finegrained = false;
        };
        nvidiaSettings = true;
      };
    };

    boot = {
      kernelParams = [
        "nvidia_drm.modeset=1"
        "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
      ];
      kernelModules = [
        "nvidia_uvm"
      ];
    };

    services.xserver = {
      enable = true;
      videoDrivers = ["nvidia"];
    };

    environment.sessionVariables = {
      GBM_BACKEND = "nvidia-drm";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
      LIBVA_DRIVER_NAME = "nvidia";
      NVD_BACKEND = "direct";
    };
  };
}
