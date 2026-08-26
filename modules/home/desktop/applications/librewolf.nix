{
  flake.homeModules.librewolf = {pkgs, ...}: {
    home.packages = with pkgs; [librewolf];

    xdg.mimeApps.defaultApplications = {
      "x-scheme-handler/http" = ["librewolf.desktop"];
      "x-scheme-handler/https" = ["librewolf.desktop"];
    };

    desktop.browser.name = "librewolf";
    persist.directories = [
      ".cache/librewolf"
      ".config/librewolf"
    ];
  };
}
