{
  inputs,
  self,
}: {
  mkNixosHost = import ./mk-nixos-host.nix {inherit inputs self;};
}
