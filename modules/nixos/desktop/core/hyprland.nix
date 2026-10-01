{
  flake.nixosModules.hyprland = {
    programs = {
      hyprland = {
        enable = true;
        withUWSM = true;
      };
      iio-hyprland.enable = true;
    };
  };
}
