{
  lib,
  pkgs,
  inputs,
  config,
  ...
}: {
  imports = [
    ./development
  ];

  home = {
    homeDirectory = "/home/max";
    stateVersion = "25.11";
  };

# Ensure notes directory exists
  home.activation.ensureNotesDir = lib.hm.dag.entryAfter ["writeBoundary"] ''
    mkdir -p "$HOME/notes"
  '';

  programs.git = {
    settings.user = {
      name = "9Prestidigitator";
      email = "9Prestidigitator@gmail.com";
    };
  };
}
