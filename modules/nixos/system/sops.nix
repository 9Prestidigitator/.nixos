{inputs, ...}: {
  flake.nixosModules.sops = {pkgs, ...}: {
    imports = [inputs.sops-nix.nixosModules.sops];
    sops = {
      age.keyFile = "/etc/sops/age/keys.txt";
      defaultSopsFormat = "yaml";
    };
    environment.systemPackages = with pkgs; [sops age];

    persist.directories = ["/etc/sops"];
  };
}
