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
    services.xserver = {
      enable = true;
      videoDrivers = ["nvidia"];
    };
  };
}
