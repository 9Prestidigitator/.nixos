{
  flake.nixosModules.wine = {pkgs, ...}: {
    environment.systemPackages = let
      # TODO(max): EXPERIMENT
      latestWineForYabridge =
        (pkgs.wineWow64Packages.base.override {
          wineRelease = "staging"; # or "unstable"
        }).overrideAttrs (old: {
          patches =
            (old.patches or [])
            ++ [
              (pkgs.fetchurl {
                url = "https://gitlab.winehq.org/-/project/5/uploads/dea8a1e711846f7e7642c16eacd284b4/bug51357.patch";
                hash = "sha256-ZfW94gCDLGauKEZOid7ndQsaPA6SVGk22CQ3EBWAPm8=";
              })
            ];
        });

      wineSetForYabridge =
        pkgs.wineWow64Packages
        // {
          yabridge = latestWineForYabridge;
        };

      yabridgePatched = pkgs.yabridge.override {
        wineWow64Packages = wineSetForYabridge;
      };

      yabridgectlPatched = pkgs.yabridgectl.override {
        wineWow64Packages = wineSetForYabridge;
        yabridge = yabridgePatched;
      };
    in
      with pkgs; [
        wineWow64Packages.yabridge
        yabridge
        yabridgectl
        winetricks
        winePackages.fonts
        wineasio
      ];
  };
}
