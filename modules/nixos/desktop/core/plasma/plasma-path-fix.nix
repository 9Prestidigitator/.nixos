{
  flake.nixosModules.plasma-path-fix = {lib, ...}: {
    # Workaround for NixOS/nixpkgs#126590 — "excessively long environment
    # variables in KDE Plasma".

    # On NixOS, plasma-workspace's Qt wrapper prefixes XDG_DATA_DIRS with the
    # share/ directory of every package in its closure. The result is an
    # XDG_DATA_DIRS of roughly 18 KB with heavy duplication, inherited by every
    # process the session spawns. Because applications stat every entry in that
    # list when looking up .desktop files, icons, and mime data at startup, this
    # shows up as everything in the session feeling slow to launch — and it is
    # far worse on storage with high per-operation latency, such as a VM disk.

    # The fix,
    # https://github.com/NixOS/nixpkgs/issues/126590#issuecomment-3194531220:
    # build a single derivation that merges the contents of all those share/
    # directories into one, strip the wrapper's XDG_DATA_DIRS injection, and
    # point it at the merged directory instead. XDG_DATA_DIRS goes from ~18 KB
    # and hundreds of entries down to two.

    # COST: this rebuilds plasma-workspace from source.
    nixpkgs.overlays = lib.singleton (
      final: prev: {
        kdePackages =
          prev.kdePackages
          // {
            plasma-workspace = let
              basePkg = prev.kdePackages.plasma-workspace;

              xdgdataPkg = prev.stdenv.mkDerivation {
                name = "${basePkg.name}-xdgdata";
                buildInputs = [basePkg];
                dontUnpack = true;
                dontFixup = true;
                dontWrapQtApps = true;
                installPhase = ''
                  mkdir -p $out/share
                  ( IFS=:
                    for DIR in $XDG_DATA_DIRS; do
                      if [[ -d "$DIR" ]]; then
                        cp -r $DIR/. $out/share/
                        chmod -R u+w $out/share
                      fi
                    done
                  )
                '';
              };
            in
              basePkg.overrideAttrs {
                preFixup = ''
                  for index in "''${!qtWrapperArgs[@]}"; do
                    if [[ ''${qtWrapperArgs[$((index+0))]} == "--prefix" ]] && [[ ''${qtWrapperArgs[$((index+1))]} == "XDG_DATA_DIRS" ]]; then
                      unset -v "qtWrapperArgs[$((index+0))]"
                      unset -v "qtWrapperArgs[$((index+1))]"
                      unset -v "qtWrapperArgs[$((index+2))]"
                      unset -v "qtWrapperArgs[$((index+3))]"
                    fi
                  done
                  qtWrapperArgs=("''${qtWrapperArgs[@]}")
                  qtWrapperArgs+=(--prefix XDG_DATA_DIRS : "${xdgdataPkg}/share")
                  qtWrapperArgs+=(--prefix XDG_DATA_DIRS : "$out/share")
                '';
              };
          };
      }
    );
  };
}
