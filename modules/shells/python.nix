{
  perSystem = {pkgs, ...}: {
    devShells.python = pkgs.mkShell {
      name = "Run a python script";
      shellHook = ''
        export SHELL="/run/current-system/sw/bin/bash"
      '';
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
