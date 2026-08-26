{
  flake.homeModules.brave = {pkgs, ...}: {
    home.packages = with pkgs; [brave];

    persist.directories = [
      ".cache/BraveSoftware"
      ".config/BraveSoftware"
    ];
  };
}
