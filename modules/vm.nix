{
  pkgs,
  lib,
  inputs,
  config,
  ...
}: {
  options = {
    vm.enable = lib.mkEnableOption "Enable Virtual Machine support";
  };

  config = lib.mkIf config.vm.enable {
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
