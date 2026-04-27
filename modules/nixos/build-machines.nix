{
  flake.nixosModules.build-machines = {config, ...}: {
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
    system.activationScripts.rootSshConfig.text = ''
      mkdir -m 700 -p /root/.ssh
      cat > /root/.ssh/config <<'EOF'
      Host builder
        HostName 10.123.78.170
        IdentitiesOnly yes
        IdentityFile ${config.sops.secrets."ssh/builders/ink".path}
        User nixremote
      EOF
      chmod 600 /root/.ssh/config
    '';
  };
}
