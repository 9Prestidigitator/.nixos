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
        "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
        "nvidia_drm.modeset=1"
      ];
    };

    services.xserver = {
      enable = true;
      videoDrivers = ["nvidia"];
    };
  };
}
