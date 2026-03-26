{inputs, ...}: {
  flake.nixosModules.plasma = {pkgs, ...}: {
    services.desktopManager.plasma6 = {
      enable = true;
    };

    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      settings.General.DisplayServer = "wayland";
    };

    # On-screen keyboard
    environment.systemPackages = with pkgs; [
      maliit-keyboard
      maliit-framework
      inputs.kwin-effects-forceblur.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
  };
}
