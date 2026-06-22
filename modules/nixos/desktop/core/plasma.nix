{inputs, ...}: {
  flake.nixosModules.plasma = {
    pkgs,
    lib,
    ...
  }: {
    services = {
      desktopManager.plasma6.enable = true;
      displayManager.plasma-login-manager.enable = true;
    };

    # Disable KWallet hooks so Plasma uses GNOME Keyring instead.
    services.gnome.gnome-keyring.enable = true;
    programs.seahorse.enable = true;
    security.pam.services = {
      login.kwallet.enable = lib.mkForce false;
      kde.kwallet.enable = lib.mkForce false;
    };
    xdg.portal.extraPortals = lib.mkForce [
      pkgs.gnome-keyring
      pkgs.kdePackages.xdg-desktop-portal-kde
      pkgs.xdg-desktop-portal-gtk
    ];

    environment.plasma6.excludePackages = with pkgs.kdePackages; [
      kwallet
      kwallet-pam
      kwalletmanager
    ];

    # On-screen keyboard
    environment = {
      systemPackages = with pkgs; [
        kdePackages.dolphin
        kdePackages.kio-extras
        kdePackages.karousel
        kdePackages.dynamic-workspaces
        inputs.kwin-effects-glass.packages.${pkgs.system}.default
        inputs.kwin-effects-better-blur-dx.packages.${pkgs.system}.default
        maliit-keyboard
        maliit-framework
      ];
      sessionVariables.NIXOS_OZONE_WL = "1";
    };

    programs.chromium.extensions = ["cimiefiiaegbelhefglklhhakcgmhkai"];
    xdg.mime.defaultApplications."inode/directory" = ["org.kde.dolphin.desktop"];

    persist = {
      directories = ["/var/lib/plasmalogin"];
      userDirs = [
        ".config/dolphin"
        ".config/session"

        ".local/share/dolphin"
        ".local/share/kwalletd"
        ".local/share/kscreen"
        ".local/share/kactivitymanagerd"

        # TODO(max): Temporary fix. This is because kde plasma does NOT like
        # writing to individual preserved files for some reason.
        ".local/state"
      ];
      userFiles = [
        # ".config/kwinrc"
        # ".config/ksmserverrc"
        # ".config/kwinoutputconfig.json"

        # ".local/state/kactivitymanagerdstaterc"
        # ".local/state/dolphinstaterc"
        # ".local/state/plasmasessionrestorestaterc"
        # ".local/state/kwinstaterc"
        # ".local/state/plasmashellstaterc"
      ];
    };
  };
}
