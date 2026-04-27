{
  flake.homeModules.essentials = {pkgs, ...}: {
    xdg = {
      userDirs = {
        enable = true;
        createDirectories = true;
      };
      terminal-exec = {
        enable = true;
        package = pkgs.xdg-terminal-exec;
        settings.default = ["kitty.desktop"];
      };
    };
  };
}
