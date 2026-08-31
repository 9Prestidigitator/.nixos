{self, ...}: {
  flake.homeModules.fish = {
    import = [self.homeModules.aliases];

    programs = {
      fish.enable = true;
    };

    programs.zoxide.enableFishIntegration = true;

    persist = {
      directories = [".local/share/fish"];
    };
  };
}
