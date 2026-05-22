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
      maliit-keyboard
      maliit-framework
    ];

    persist = {
      userDirs = [
        ".local/share/kwalletd"
        ".config/session"
        ".local/state/ksmserver"
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
