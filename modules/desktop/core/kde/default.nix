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
      mobile.enable = true;
    };

    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };

    # Touch-friendly settings
    services.xserver.libinput = {
      enable = true;
      touchpad.naturalScrolling = true;
    };

    # On-screen keyboard
    environment.systemPackages = with pkgs; [
      maliit-keyboard
      # or
      squeekboard
    ];
  };
}
