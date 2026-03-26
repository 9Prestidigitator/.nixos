{
  flake.nixosModules.buildMachines = {
    nix = {
      buildMachines = [
        {
          hostName = "builder";
          system = "x86_64-linux";
          protocol = "ssh-ng";
          maxJobs = 4;
          speedFactor = 2;
          supportedFeatures = ["nixos-test" "benchmark" "big-parallel" "kvm"];
        }
      ];
      distributedBuilds = true;
    };
  };
}
