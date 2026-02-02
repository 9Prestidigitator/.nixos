{pkgs}:
pkgs.mkShell {
  name = "base";
  packages = with pkgs; [
    # C/C++
    gcc

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

    # C#
    dotnetCorePackages.sdk_9_0-bin
    csharpier

    # etc
    nodejs_24
    matlab-language-server
    bash-language-server
    texlab
  ];
};
