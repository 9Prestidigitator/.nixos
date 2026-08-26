{
  flake.userModules.guest.homeModule = {
    home = {
      username = "guest";
      homeDirectory = "/home/guest";
    };

    xdg.userDirs = {
      enable = true;
      createDirectories = true;
    };
  };
}
