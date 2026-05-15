{self, ...}: {
  flake.nixosModules.gitlab = {
    imports = [self.nixosModules.sops];

    services.gitlab = {
      enable = true;
    };
  };
}
