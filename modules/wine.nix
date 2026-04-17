{
  flake.nixosModules.wine = {
    pkgs,
    lib,
    ...
  }: {
    environment.systemPackages = [
      (pkgs.wineWow64Packages.stagingFull.overrideAttrs (old: {
        patches =
          (old.patches or [])
          ++ [
            (pkgs.fetchurl {
              url = "https://gitlab.winehq.org/-/project/5/uploads/dea8a1e711846f7e7642c16eacd284b4/bug51357.patch";
              hash = lib.fakeHash;
            })
          ];
      }))
    ];
  };
}
