{
  perSystem = {pkgs, ...}: {
    devShells.default = pkgs.mkShell {
      name = "base";
      shellHook = ''
        export SHELL="/run/current-system/sw/bin/bash"
      '';
      packages = with pkgs; [
        # C/C++
        cmake
        gcc
        clang-tools
        vscode-extensions.vadimcn.vscode-lldb

        # Rust
        rustc
        cargo
        rust-analyzer

        # Nix
        nixd
        alejandra

        # Python
        (python3.withPackages (ps: with ps; [numpy debugpy]))
        uv
        basedpyright
        ruff
        black

        # C#
        dotnetCorePackages.sdk_9_0-bin
        omnisharp-roslyn
        csharpier
        netcoredbg

        # Latex
        texliveSmall
        texlab
        tex-fmt
        zathuraPkgs.zathura_pdf_poppler

        # Bash
        bash-language-server
        shfmt

        # etc
        prettier
        prettierd
        taplo
        jq
        typescript-language-server
        matlab-language-server
        qt6.qtdeclarative
      ];
      env = {
        CODELLDB_PATH = "${pkgs.vscode-extensions.vadimcn.vscode-lldb}/share/vscode/extensions/vadimcn.vscode-lldb/adapter/codelldb";
      };
    };
  };
}
