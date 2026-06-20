{
  flake.nixosModules.fprintd = {
    services.fprintd.enable = true;

    security.pam.services = {
      login.fprintAuth = true;
      sudo.fprintAuth = true;
    };
    persist.directories = ["/var/lib/fprint"];
  };
}
