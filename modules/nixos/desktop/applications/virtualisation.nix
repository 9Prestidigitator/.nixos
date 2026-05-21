{
  flake.nixosModules.virtualisation = {pkgs, ...}: {
    virtualisation.libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        runAsRoot = true;
        swtpm.enable = true;
      };
    };

    environment.systemPackages = with pkgs; [
      qemu
      virt-manager
    ];

    persist.directories = [
      "/var/lib/libvirt"
      ".config/virt-manager"
    ];
  };
}
