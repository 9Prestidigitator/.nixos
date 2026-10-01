{self, ...}: {
  flake.nixosModules.hyprland = {
    imports = [self.nixosModules.super-tap];
    programs = {
      hyprland = {
        enable = true;
        withUWSM = true;
      };
      iio-hyprland.enable = true;
    };
  };
}
