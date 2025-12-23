{
  lib,
  pkgs,
  inputs,
  config,
  ...
}: {
  imports = [
    inputs.noctalia.homeModules.default
    ./development
    ./desktop
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
