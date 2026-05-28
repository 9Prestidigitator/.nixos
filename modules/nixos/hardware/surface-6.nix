{inputs, ...}: {
  flake.nixosModules.surface-6 = {pkgs, ...}: {
    imports = [inputs.nixos-hardware.nixosModules.microsoft-surface-common];

    hardware = {
      microsoft-surface.kernelVersion = "longterm";
      sensor.iio.enable = true;
    };

    environment.systemPackages = with pkgs; [iptsd surface-control libinput libinput-gestures];
    services.udev.packages = with pkgs; [iptsd surface-control];

    # The default tty font size is too small!
    console.font = "ter-v32b";
  };
}
