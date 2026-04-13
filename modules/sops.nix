{inputs, ...}: {
  flake.nixosModules.sops = {pkgs, ...}: {
    imports = [inputs.sops-nix.nixosModules.sops];
    sops = {
      defaultSopsFile = ../secrets/secrets.yaml;
      defaultSopsFormat = "yaml";
    };
    environment.systemPackages = with pkgs; [sops];
  };
}
