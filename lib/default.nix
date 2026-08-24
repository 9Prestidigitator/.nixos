{
  inputs,
  self,
}: {
  mkNixosHost = import ./mk-nixos-host.nix {inherit inputs self;};
  mkHomeHost = import ./mk-home.nix {inherit inputs self;};
}
