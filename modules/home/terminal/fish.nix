{self, ...}: {
  flake.homeModules.fish = {
    imports = [self.homeModules.aliases];

    programs = {
      fish = {
        enable = true;
        interactiveShellInit = ''
          set -g fish_greeting
        '';
      };
    };

    programs.zoxide.enableFishIntegration = true;

    persist = {
      directories = [".local/share/fish"];
    };
  };
}
