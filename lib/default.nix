{
  inputs,
  self,
}: {
  mkNixosHost = import ./mk-nixos-system.nix {inherit inputs self;};
}
