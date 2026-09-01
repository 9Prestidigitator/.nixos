{self, ...}: {
  flake.homeModules.fish = {
    pkgs,
    lib,
    ...
  }: {
    imports = [self.homeModules.aliases];

    programs = {
      fish = {
        enable = true;
        interactiveShellInit = ''
          set -g fish_greeting
          ${lib.getExe pkgs.any-nix-shell} fish --info-right | source
        '';
      };
    };

    programs.zoxide.enableFishIntegration = true;

    persist = {
      directories = [".local/share/fish"];
    };
  };
}
