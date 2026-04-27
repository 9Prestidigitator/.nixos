{
  flake.nixosModules.build-machines = {config, ...}: {
    sops.secrets."ssh/builders/ink" = {};
    nix = {
      distributedBuilds = true;
      settings.builders-use-substitutes = true;
      buildMachines = [
        {
          hostName = "10.123.78.170";
          sshUser = "nixremote";
          sshKey = config.sops.secrets."ssh/builders/ink".path;

          system = "x86_64-linux";
          protocol = "ssh-ng";
          maxJobs = 8;
          speedFactor = 3;
          supportedFeatures = [
            "nixos-test"
            "benchmark"
            "big-parallel"
            "kvm"
          ];
        }
      ];
    };
  };
}
