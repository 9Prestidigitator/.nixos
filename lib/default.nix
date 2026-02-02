{inputs, ...}: let
  hosts = import ./hosts.nix {
    inputs = inputs;
  };
  systems = import ./systems.nix {
    nixpkgs = inputs.nixpkgs;
  };
in {
  inherit (hosts) mkHost genHosts;
  inherit (systems) eachSystem;
  inherit (systems) pkgsFor;
}
