{
  perSystem = {pkgs, ...}: {
    devShells.python = pkgs.mkShell {
      name = "python";
      packages = with pkgs; [
        (python3.withPackages
          (ps:
            with ps; [
              numpy
              pandas
              matplotlib
              scikit-learn
              # tools
              black
              debugpy
            ]))

        basedpyright
          ruff
      ];
    };
  };
}
