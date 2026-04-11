{
  perSystem = {pkgs, ...}: {
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
  };
}
