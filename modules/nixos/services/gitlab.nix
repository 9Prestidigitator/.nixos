{self, ...}: {
  flake.nixosModules.gitlab = {
    imports = [self.nixosModules.sops];

    services.gitlab = {
      enable = true;
    };

    persist.directories = [
      "/var/gitlab"
      "/var/lib/postgresql"
      "/var/lib/redis-gitlab"
    ];
  };
}
