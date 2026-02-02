{pkgs}: {
  default = import ./shell.nix {inherit pkgs;};
  nix = import ./nix.nix {inherit pkgs;};
}
