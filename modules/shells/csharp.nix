{
  perSystem = {pkgs, ...}: {
    devShells.csharp = pkgs.mkShell {
      name = "csharp";
      packages = with pkgs; [
        dotnetCorePackages.sdk_10_0
        dotnetCorePackages.runtime_10_0
        nuget

        omnisharp-roslyn
        netcoredbg
        csharpier
      ];
    };
  };
}
