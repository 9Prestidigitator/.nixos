{pkgs}: let
  package = import ./package.nix {inherit pkgs;};
  nixosModule = import ./module.nix;
in {
  inherit package nixosModule;
}
