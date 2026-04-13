{inputs, ...}: {
  flake.nixosModules.sops = {
    imports = [inputs.sops-nix.nixosModules.sops];
    sops = {
      defaultSopsFile = ../secrets/secrets.yaml;
      defaultSopsFormat = "yaml";
    };
  };
}
