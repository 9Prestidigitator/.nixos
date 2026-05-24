{
  lib,
  modulesPath,
  ...
}: {
  imports = [(modulesPath + "/profiles/qemu-guest.nix")];

  boot.initrd.availableKernelModules = ["ahci" "xhci_pci" "virtio_pci" "virtio_blk" "usb_storage" "sd_mod" "sr_mod"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = ["kvm-intel"];
  boot.extraModulePackages = [];

  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  services.xserver = {
    enable = true;
    videoDrivers = ["modesetting"];
  };

  environment.sessionVariables = {
    # Makes GNOME/Qt usable when the VM GPU has broken accel
    LIBGL_ALWAYS_SOFTWARE = "1";
    GSK_RENDERER = "cairo";
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
