{
  lib,
  config,
  inputs,
  pkgs,
  ...
}: {
  home.file.".config/noctalia/plugins" = {
    recursive = true;
    source = pkgs.fetchFromGitHub {
      owner = "noctalia-dev";
      repo = "noctalia-plugins";
      rev = "e41dffb965ccb3c2b1e3a69a5bf153c99525e26a";
      hash = "sha256-L8t/nY5/lORGqEtubx/34uSbGyWkQfadGom7w8AZznI=";
      sparseCheckout = [
        "privacy-indicator"
      ];
    };
  };
}
