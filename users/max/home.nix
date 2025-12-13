{
  lib,
  pkgs,
  config,
  ...
}: let
  syncRepo = import ./sync-repo.nix {inherit pkgs;};
in {
  programs.git = {
    settings.user = {
      name = "9Prestidigitator";
      email = "9Prestidigitator@gmail.com";
    };
  };
  home.activation.syncNvimDotfiles = lib.hm.dag.entryAfter ["writeBoundary"] ''
    $DRY_RUN_CMD ${
      syncRepo {
        url = "https://github.com/9Prestidigitator/nvim.git";
        destination = "${config.home.homeDirectory}/.config/nvim";
      }
    }
  '';
}
