{
  perSystem = {pkgs, ...}: {
    devShells.markdown = pkgs.mkShell {
      name = "markdown";
      packages = with pkgs; [
        # etc
        prettier
        prettierd
      ];
    };
  };
}
