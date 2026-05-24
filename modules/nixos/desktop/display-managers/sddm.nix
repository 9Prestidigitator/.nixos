{
  flake.nixosModules.sddm = {pkgs, ...}: let
    custom = pkgs.sddm-astronaut.override {
      embeddedTheme = "black_hole";
    };
  in {
    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      settings = {
        General.DisplayServer = "wayland";
        Theme = {
          Current = "sddm-astronaut-theme";
          CursorTheme = "breeze_cursors";
        };
      };
      theme = "sddm-astronaut-theme";
      extraPackages = [custom];
    };

    environment.systemPackages = with pkgs; [
      sddm-astronaut
      kdePackages.qtmultimedia
    ];
    fonts.packages = with pkgs; [
      inter
    ];
  };
}
