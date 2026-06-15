{self, ...}: {
  flake.nixosModules.ink-build-machine = {config, ...}: {
    imports = [self.nixosModules.sops];

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
          sshKey = config.sops.secrets."ssh/builders".path;
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

  flake.nixosModules.surface-build-machine = {config, ...}: {
    imports = [self.nixosModules.sops];

    programs.ssh.knownHosts.surface = {
      hostNames = ["10.123.78.31" "surface"];
      publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFv97qAok1Yc9Pdx0tCWMyiYtbw0WNyqhqZg48DBMRC6 root@surface"; # You can find this at /etc/ssh/ssh_host_<type>_key.pub
    };

    nix = {
      distributedBuilds = true;
      settings.builders-use-substitutes = true;
      buildMachines = [
        {
          hostName = "10.123.78.31";
          sshUser = "nixremote";
          sshKey = config.sops.secrets."ssh/builders".path;
          protocol = "ssh-ng";
          # You can find via base64 -w0 /etc/ssh/ssh_host_<type>_key.pub
          publicHostKey = "c3NoLWVkMjU1MTkgQUFBQUMzTnphQzFsWkRJMU5URTVBQUFBSUZ2OTdxQW9rMVljOVBkeDB0Q1dNeWlZdGJ3MFdOeXFocVpnNDhEQk1SQzYgcm9vdEBzdXJmYWNlCg==";
          systems = ["x86_64-linux" "builtin"];
          maxJobs = 8;
          speedFactor = 2;
          supportedFeatures = [
            "nixos-test"
            "benchmark"
            "kvm"
          ];
        }
      ];
    };
  };
}
