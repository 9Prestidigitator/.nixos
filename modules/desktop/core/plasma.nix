{inputs, ...}: {
  flake.nixosModules.plasma = {pkgs, ...}: {
    services = {
      desktopManager.plasma6 = {
        enable = true;
      };
      displayManager.plasma-login-manager.enable = true;
    };

    # On-screen keyboard
    environment.systemPackages = with pkgs; [
      maliit-keyboard
      maliit-framework
      inputs.kwin-effects-forceblur.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
  };
}
