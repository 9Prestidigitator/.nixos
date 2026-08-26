{
  flake.homeModules.brave = {pkgs, ...}: {
    home.packages = with pkgs; [brave];

    xdg.mimeApps.defaultApplications = {
      "x-scheme-handler/http" = ["com.brave.Browser.desktop"];
      "x-scheme-handler/https" = ["com.brave.Browser.desktop"];
    };

    desktop.browser.name = "brave";
    persist.directories = [
      ".cache/BraveSoftware"
      ".config/BraveSoftware"
    ];
  };
}
