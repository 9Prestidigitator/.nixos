{
  self,
  inputs,
  ...
}: let
  hosts = import ./hosts.nix {
    self = self;
    inputs = inputs;
  };
in {
  inherit (hosts) mkHost genHosts;
}
