{
  lib,
  pkgs,
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

  programs.git = {
    settings.user = {
      name = "9Prestidigitator";
      email = "9Prestidigitator@gmail.com";
    };
  };
}
