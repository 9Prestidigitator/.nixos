{pkgs}:
pkgs.mkShell {
  name = "python";
  shellHook = ''
    export SHELL="/run/current-system/sw/bin/bash"
  '';
  packages = with pkgs; [
    # Python
    python3
    uv
    basedpyright
    ruff
    black
    (python3.withPackages (ps: [ps.debugpy]))
  ];
}
