{
  flake.nixosModules.braveBrowser = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [syncthing];
    services.syncthing = {
      enable = true;
      openDefaultPorts = true;
    };
  };
}
