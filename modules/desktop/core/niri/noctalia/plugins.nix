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
      hash = "sha256-4GhsY5Uz0kAaZJpqIoBRoRrnVW2T2tk0xGgwP6Tpvbs=";
      sparseCheckout = [
        "privacy-indicator"
        "catwalk"
      ];
    };
  };
  home.file.".config/noctalia/plugins/privacy-indicator/settings.json" = {
    text = builtins.toJSON {
      hideInactive = true;
      iconSpacing = 4;
      removeMargins = false;
    };
  };
  home.file.".config/noctalia/plugins.json" = {
    text = builtins.toJSON {
      sources = [
        {
          enabled = true;
          name = "Official Noctalia Plugins";
          url = "https://github.com/noctalia-dev/noctalia-plugins";
        }
      ];
      states = {
        catwalk = {
          enabled = true;
          sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
        };
        privacy-indicator = {
          enabled = true;
          sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
        };
      };
    };
  };
}
