{inputs, ...}: let
  hosts = import ./hosts.nix {
    inputs = inputs;
  };
in {
  inherit (hosts) mkHost genHosts;
}
