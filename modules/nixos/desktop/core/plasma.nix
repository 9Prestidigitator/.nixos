{
  flake.nixosModules.plasma = {pkgs, ...}: {
    services = {
      desktopManager.plasma6 = {
        enable = true;
      };
      displayManager.plasma-login-manager.enable = true;
    };

    # On-screen keyboard
    environment.systemPackages = with pkgs; [
      kdePackages.dolphin
      kdePackages.kio-extras
      maliit-keyboard
      maliit-framework
    ];

    xdg.mime.defaultApplications."inode/directory" = ["org.kde.dolphin.desktop"];

    persist = {
      userDirs = [
        ".local/share/kwalletd"
        ".config/session"
        ".local/state/ksmserver"
        ".config/dolphin"
        ".local/share/kscreen"
        ".local/share/kactivitymanagerd"
        ".local/share/dolphin"
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
