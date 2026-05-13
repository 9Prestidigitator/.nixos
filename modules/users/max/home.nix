{inputs, ...}: {
  flake.homeModules.max = {
    lib,
    config,
    ...
  }: {
    imports = [inputs.sops-nix.homeManagerModules.sops];

    home = {
      username = "max";
      homeDirectory = "/home/max";
    };

    sops = {
      age.keyFile = "/home/max/.config/sops/age/keys.txt";
      defaultSopsFile = ../../../secrets/max.yaml;
      defaultSopsFormat = "yaml";
      secrets = {
        "ssh/gh".mode = "0600";
        "ssh/ink".mode = "0600";
        "ssh/papyr".mode = "0600";
        "ssh/surface".mode = "0600";
        "ssh/cardboard".mode = "0600";
        "mullvad".mode = "0600";
        "syncthing/key".mode = "0600";
        "syncthing/perm".mode = "0600";
      };
    };

    programs = {
      git.settings = {
        url."ssh://git@github.com".insteadOf = "https://github.com";
        user = {
          name = "9Prestidigitator";
          email = "9Prestidigitator@gmail.com";
        };
      };
      ssh = {
        enable = true;
        enableDefaultConfig = false;
        matchBlocks.github = {
          host = "github.com";
          hostname = "github.com";
          user = "git";
          identityFile = config.sops.secrets."ssh/gh".path;
          identitiesOnly = true;
        };
      };
    };

    home.activation.ensureNotesDir = lib.hm.dag.entryAfter ["writeBoundary"] ''mkdir -p "$HOME/notes"'';
  };
}
