{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ../../home/core.nix
    ../../home/development
  ];

  programs.git = {
    settings.user = {
      name = "9Prestidigitator";
      email = "9Prestidigitator@gmail.com";
    };
  };
}
