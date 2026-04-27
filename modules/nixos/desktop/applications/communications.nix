{
  flake.nixosModules.communications = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      signal-desktop
      element-desktop
    ];
  };
}
