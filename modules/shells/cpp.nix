{
  perSystem = {pkgs, ...}: {
    devShells.cpp = pkgs.mkShell {
      name = "c++";
      packages = with pkgs; [
        pkg-config
        cmake
        gcc
        clang-tools
        vscode-extensions.vadimcn.vscode-lldb
      ];
      env = {
        CODELLDB_PATH = "${pkgs.vscode-extensions.vadimcn.vscode-lldb}/share/vscode/extensions/vadimcn.vscode-lldb/adapter/codelldb";
      };
    };
  };
}
