{
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
      maliit-keyboard
      maliit-framework
    ];

    xdg.mime.defaultApplications."inode/directory" = ["org.kde.dolphin.desktop"];

    persist = {
      userDirs = [
        ".config/dolphin"
        ".local/share/dolphin"

        ".local/share/kwalletd"

        ".local/state/ksmserver"
        ".config/session"
        ".local/share/kscreen"
        ".local/share/kactivitymanagerd"
      ];
      userFiles = [
        ".config/ksmserverrc"
        ".config/kwinoutputconfig.json"
        ".config/kactivitymanagerdrc"
        ".local/state/plasmasessionrestorestaterc"
      ];
    };
  };
}
