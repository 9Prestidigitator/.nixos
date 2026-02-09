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

    # Latex
    texliveSmall
    texlab
    tex-fmt
    zathuraPkgs.zathura_pdf_poppler

    # Bash
    bash-language-server
    shmft

    # Debuggers
    vscode-extensions.vadimcn.vscode-lldb
    netcoredbg
    (python3.withPackages (ps: [ps.debugpy]))

    # etc
    prettier
    prettierd
    taplo
    jq
    typescript-language-server
    matlab-language-server
    qt6.qtdeclarative
  ];
}
