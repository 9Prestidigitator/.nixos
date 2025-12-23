final: prev: {
  overwitch = prev.callPackage ./overwitch/package.nix {};
  edenEmu = prev.callPackage ./eden {};
}
