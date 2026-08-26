{
  flake.homeModules.librewolf = {pkgs, ...}: {
    home.packages = with pkgs; [librewolf];

    desktop.browser.name = "librewolf";

    persist.directories = [
      ".cache/librewolf"
      ".config/librewolf"
    ];
  };
}
