{pkgs}:
pkgs.mkShell {
  name = "markdown";
  shellHook = ''
    export SHELL="/run/current-system/sw/bin/bash"
  '';
  packages = with pkgs; [
    # etc
    prettier
    prettierd
    typescript-language-server
    texlab
  ];
}
