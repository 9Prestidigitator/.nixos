{
  flake.nixosModules.wine = {pkgs, ...}: {
    environment.systemPackages = let
      latestWineForYabridge =
        (
          pkgs.wineWow64Packages.base.override {wineRelease = "staging";}
        ).overrideAttrs (old: {
          patches =
            (old.patches or [])
            ++ [
              (pkgs.fetchurl {
                url = "https://gitlab.winehq.org/-/project/5/uploads/dea8a1e711846f7e7642c16eacd284b4/bug51357.patch";
                hash = "sha256-ZfW94gCDLGauKEZOid7ndQsaPA6SVGk22CQ3EBWAPm8=";
              })
            ];
        });

      wineSetForYabridge = pkgs.wineWow64Packages // {yabridge = latestWineForYabridge;};

      yabridgePatched = pkgs.yabridge.override {wineWow64Packages = wineSetForYabridge;};
      yabridgectlPatched = pkgs.yabridgectl.override {
        wineWow64Packages = wineSetForYabridge;
        yabridge = yabridgePatched;
      };
    in
      with pkgs; [
        latestWineForYabridge
        yabridgePatched
        yabridgectlPatched
        winetricks
        winePackages.fonts
        wineasio
      ];

    persist.userDirs = [
      ".wine"
      ".local/share/applications/wine"
      ".local/share/mime"
    ];
  };
}
