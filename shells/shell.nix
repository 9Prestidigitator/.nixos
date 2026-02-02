{pkgs}:
pkgs.mkShell {
  name = "base";
  shellHook = ''
    export SHELL="/run/current-system/sw/bin/bash"
  '';
  packages = with pkgs; [
    # C/C++
    cmake
    gcc
    clang-tools

    # Rust
    rustc
    cargo
    rust-analyzer

    # Nix
    nixd
    alejandra

    # Python
    python3
    uv
    basedpyright
    ruff
    black

    # C#
    dotnetCorePackages.sdk_9_0-bin
    omnisharp-roslyn
    csharpier

    # etc
    prettier
    prettierd
    typescript-language-server
    matlab-language-server
    bash-language-server
    texlab
  ];
}
