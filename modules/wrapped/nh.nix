{inputs, ...}: {
  perSystem = {pkgs, ...}: {
    packages.nh = inputs.wrappers.wrappers.nh.wrap {
      inherit pkgs;
      package = pkgs.nh;
      flake = "$HOME/.nixos";
    };
  };
}
