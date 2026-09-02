{
  flake.homeModules.direnv = {
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    persist.directories = [".local/share/direnv"];
  };
}
