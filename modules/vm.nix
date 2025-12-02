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
    services.libvirtd.enable = true;

    environment.systemPackages = with pkgs; [
      qemu
      virt-manager
    ];
  };
}
