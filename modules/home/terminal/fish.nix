{self, ...}: {
  flake.homeModules.fish = {
    imports = [self.homeModules.aliases];

    programs = {
      fish.enable = true;
    };

    programs.zoxide.enableFishIntegration = true;

    persist = {
      directories = [".local/share/fish"];
    };
  };
}
