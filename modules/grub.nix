{
  flake.nixosModules.grub = {pkgs, ...}: {
    boot = {
      loader = {
        efi.canTouchEfiVariables = true;
        grub = {
          enable = true;
          device = "nodev";
          efiSupport = true;
          useOSProber = true;
          theme = "${pkgs.kdePackages.breeze-grub}/grub/themes/breeze";
        };
      };
    };
  };
}
