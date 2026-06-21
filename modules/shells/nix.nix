{
  perSystem = {pkgs, ...}: rec {
    devShells.nix = pkgs.mkShell {
      name = "nix";
      packages = with pkgs; [
        # Nix
        nixd
        alejandra
        bash-language-server
        prettierd
      ];
    };

    devShells.default = devShells.nix;
  };
}
