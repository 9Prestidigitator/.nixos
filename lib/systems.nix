{nixpkgs}: let
  eachSystem = nixpkgs.lib.genAttrs nixpkgs.lib.systems.flakeExposed;
in {
  eachSystem = eachSystem;
  pkgsFor = eachSystem (
    system:
      import nixpkgs {
        inherit system;
      }
  );
}
