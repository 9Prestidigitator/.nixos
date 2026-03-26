{
  flake.nixosModules.tablet = {
    services.hardware = {
      opentabletdriver.enable = true;
      uinput.enable = true;
    };
    boot.kernelModules = ["uinput"];
  };
}
