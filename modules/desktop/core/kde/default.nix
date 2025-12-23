{
  lib,
  config,
  inputs,
  pkgs,
  ...
}: let
  cfg = config.desktop;
  isKde = cfg.enable && cfg.mode == "kde";
in {
  config = lib.mkIf isKde {
    services.desktopManager.plasma6 = {
      enable = true;
    };

    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };

    i18n.inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5.addons = [
        pkgs.fcitx5-maliit
      ];
    };

    # On-screen keyboard
    environment.systemPackages = with pkgs; [
      maliit-keyboard
    ];
  };
}
