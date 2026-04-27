{inputs, ...}: {
  flake.nixosModules.sops = {pkgs, ...}: {
    imports = [inputs.sops-nix.nixosModules.sops];
    sops = {
      defaultSopsFile = ../../../secrets.yaml;
      defaultSopsFormat = "yaml";
    };
    environment.systemPackages = with pkgs; [sops age];
    home-manager.sharedModules = [inputs.sops-nix.homeManagerModules.sops];
  };
}
