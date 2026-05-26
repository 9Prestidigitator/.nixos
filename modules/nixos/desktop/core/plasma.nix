{inputs, ...}: {
  flake.nixosModules.plasma = {pkgs, ...}: {
    services = {
      desktopManager.plasma6.enable = true;
      displayManager.plasma-login-manager.enable = true;
    };

    # On-screen keyboard
    environment.systemPackages = with pkgs; [
      kdePackages.dolphin
      kdePackages.kio-extras
      kdePackages.karousel
      kdePackages.dynamic-workspaces
      inputs.kwin-effects-glass.packages.${pkgs.system}.default
      maliit-keyboard
      maliit-framework
    ];
  
    programs.chromium.extensions = ["cimiefiiaegbelhefglklhhakcgmhkai"];
    xdg.mime.defaultApplications."inode/directory" = ["org.kde.dolphin.desktop"];

    persist = {
      userDirs = [
        ".config/dolphin"
        ".local/share/dolphin"

        ".local/share/kwalletd"

        ".config/session"
        # ".local/state/ksmserver"
        # ".local/share/kscreen"
        ".local/share/kactivitymanagerd"

        ".cache"
      ];
      userFiles = [
        ".config/kwinrc"
        ".config/ksmserverrc"
        ".config/kwinoutputconfig.json"
        # ".config/kactivitymanagerdrc"
        # ".local/state/plasmasessionrestorestaterc"
      ];
    };
  };
}
