{
  flake.nixosModules.tablet = {
    # TODO(max): There are still issues when using the wacom tablet. Will have to diagnose.
    hardware = {
      opentabletdriver.enable = true;
      uinput.enable = true;
    };
    boot.kernelModules = ["uinput"];
  };
}
