{
  services.syncthing = {
    enable = true;
    openDefaultPorts = true;
    user = "max";
    dataDir = "/home/max";
  };

  home-manager.users."max" = ./home.nix;
}
