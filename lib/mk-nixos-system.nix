{
  inputs,
  self,
}: {
  system ? "x86_64-linux",
  modules,
  ...
} @ args:
inputs.nixpkgs.lib.nixosSystem (
  removeAttrs args ["modules"]
  // {
    inherit system;
    modules = [self.nixosModules.global-options] ++ modules;
  }
)
