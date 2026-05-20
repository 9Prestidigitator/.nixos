{
  flake.nixosModules.vm = {lib, modulesPath, ...}: {
    imports = [(modulesPath + "/profiles/qemu-guest.nix")];

    boot.initrd.availableKernelModules = ["ahci" "xhci_pci" "virtio_pci" "virtio_blk" "usb_storage" "sd_mod" "sr_mod"];
    boot.initrd.kernelModules = [];
    boot.kernelModules = ["kvm-intel" "kvm-amd"];
    boot.extraModulePackages = [];

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  };
}
