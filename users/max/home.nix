{
  lib,
  pkgs,
  config,
  ...
}: {
  imports = [
    ./development
  ];

  programs.git = {
    settings.user = {
      name = "9Prestidigitator";
      email = "9Prestidigitator@gmail.com";
    };
  };
}
