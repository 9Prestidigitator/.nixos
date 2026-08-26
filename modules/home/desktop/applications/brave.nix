{
  flake.homeModules.brave = {pkgs, ...}: {
    home.packages = with pkgs; [brave];

    desktop.browser.name = "brave";

    persist.directories = [
      ".cache/BraveSoftware"
      ".config/BraveSoftware"
    ];
  };
}
