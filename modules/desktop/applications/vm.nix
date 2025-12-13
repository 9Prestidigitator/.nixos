{
  pkgs,
  lib,
  inputs,
  config,
  ...
}: {
  config = lib.mkIf config.desktop.vm.enable {
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
  };
}
