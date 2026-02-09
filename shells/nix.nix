{pkgs}:
pkgs.mkShell {
  name = "nix";
  shellHook = ''
    export SHELL="/run/current-system/sw/bin/bash"
  '';
  packages = with pkgs; [
    # Nix
    nixd
    alejandra
    bash-language-server
    prettierd
  ];
}
