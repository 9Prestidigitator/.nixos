{
  flake.nixosModules.syncthing = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [syncthing];
    services.syncthing = {
      enable = true;
      openDefaultPorts = true;
    };
  };
}
