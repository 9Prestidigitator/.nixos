{
  flake.nixosModules.tablet = {
    hardware = {
      opentabletdriver.enable = true;
      uinput.enable = true;
    };
    boot.kernelModules = ["uinput"];
  };
}
