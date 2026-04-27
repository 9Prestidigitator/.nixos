{
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
    ];
  };
}
