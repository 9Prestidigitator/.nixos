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

    # Python
    python3
    uv
    basedpyright
    ruff

    # Nix
    nixd
    alejandra

    # etc
    nodejs_24
    dotnetCorePackages.sdk_9_0-bin
    matlab-language-server
    texlab
  ];
}
