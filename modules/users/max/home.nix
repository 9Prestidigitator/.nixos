{
  flake.homeModules.max = {
    lib,
    config,
    ...
  }: {
    home = {
      username = "max";
      homeDirectory = "/home/max";
      stateVersion = "26.05";
    };

    sops = {
      age.keyFile = "/home/max/.config/sops/age/keys.txt";
      defaultSopsFile = ../../../secrets.yaml;
      defaultSopsFormat = "yaml";
      secrets = {
        "ssh/gh".mode = "0600";
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
