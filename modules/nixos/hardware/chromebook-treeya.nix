{inputs, ...}: {
  flake.nixosModules.chromebook-treeya = {pkgs, ...}: {
    boot = {
      kernelPackages = pkgs.linuxKernel.packages.linux_6_12;
      kernelPatches = [
        {
          name = "chrultrabook-stoney-audio";
          patch = inputs.stoney-kernel + "/patches/audio.patch";
        }
      ];
    };
  };
}
