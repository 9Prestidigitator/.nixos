{
  flake.nixosModules.braveBrowser = {
    services.hardware = {
      opentabletdriver.enable = true;
      uinput.enable = true;
    };
    boot.kernelModules = ["uinput"];
  };
}
