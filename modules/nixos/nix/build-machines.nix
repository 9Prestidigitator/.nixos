{self, ...}: {
  flake.nixosModules.ink-build-machine = {config, ...}: {
    imports = [self.nixosModules.sops];

    sops.secrets."ssh/builders/ink" = {
      sopsFile = ../../../secrets/builders.yaml;
      owner = "root";
      group = "root";
      mode = "0400";
    };

    programs.ssh.knownHosts.ink = {
      hostNames = ["10.123.78.170" "ink"];
      publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJ0Y/FJPDKzaGNR/XeqeSZ4IzaJp+PiCgifWPwishRUo root@ink"; # You can find this at /etc/ssh/ssh_host_<type>_key.pub
    };

    nix = {
      distributedBuilds = true;
      settings.builders-use-substitutes = true;
      buildMachines = [
        {
          hostName = "10.123.78.170";
          sshUser = "nixremote";
          sshKey = config.sops.secrets."ssh/builders/ink".path;
          protocol = "ssh-ng";
          # You can find via base64 -w0 /etc/ssh/ssh_host_<type>_key.pub
          publicHostKey = "c3NoLWVkMjU1MTkgQUFBQUMzTnphQzFsWkRJMU5URTVBQUFBSUowWS9GSlBES3phR05SL1hlcWVTWjRJemFKcCtQaUNnaWZXUHdpc2hSVW8gcm9vdEBpbmsK";

          systems = ["x86_64-linux" "builtin"];
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
