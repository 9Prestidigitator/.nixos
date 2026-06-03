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
        ".config/session"

        ".local/share/dolphin"
        ".local/share/kwalletd"
        ".local/share/kscreen"
        ".local/share/kactivitymanagerd"

        # TODO(max): Temporary fix
        ".local/state"
      ];
      userFiles = [
        ".config/kwinrc"
        ".config/ksmserverrc"
        ".config/kwinoutputconfig.json"

        ".local/state/kactivitymanagerdstaterc"
        ".local/state/dolphinstaterc"
        ".local/state/plasmasessionrestorestaterc"
        ".local/state/kwinstaterc"
        ".local/state/plasmashellstaterc"
      ];
    };
  };
}
