{inputs, ...}: {
  networking.hostName = "vm";
  networking.networkmanager.enable = true;

  desktop = {
    enable = true;
    x11WM = "i3";
  };
}
