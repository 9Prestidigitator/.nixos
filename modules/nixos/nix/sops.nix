{inputs, ...}: {
  flake.nixosModules.sops = {pkgs, ...}: {
    imports = [inputs.sops-nix.nixosModules.sops];
    sops = {
      age.keyFile = "/etc/sops/age/keys.txt";
      defaultSopsFormat = "yaml";

      secrets."ssh/builders" = {
        sopsFile = ../../../secrets/builders.yaml;
        owner = "root";
        group = "root";
        mode = "0400";
      };
    };

    environment.systemPackages = with pkgs; [sops age];

    persist.directories = ["/etc/sops"];
  };
}
