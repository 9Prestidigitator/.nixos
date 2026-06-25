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

    environment = {
      systemPackages = with pkgs; [
        kdePackages.dolphin
        kdePackages.kio-extras
        kdePackages.karousel
        kdePackages.dynamic-workspaces
        kdePackages.kdeconnect-kde
        kdePackages.akonadi
        kdePackages.akonadi-contacts
        kdePackages.akonadi-calendar
        kdePackages.kcontacts
        kdePackages.kdepim-runtime
        kdePackages.kaccounts-integration
        kdePackages.kaccounts-providers
        kdePackages.korganizer
        kdePackages.merkuro
        kdePackages.signon-kwallet-extension
        inputs.kwin-effects-glass.packages.${pkgs.system}.default
        inputs.kwin-effects-better-blur-dx.packages.${pkgs.system}.default
      ];

      sessionVariables.NIXOS_OZONE_WL = "1";

      etc."plasmalogin.conf".text = let
        wallpaper-image = pkgs.fetchurl {
          url = "https://raw.githubusercontent.com/NixOS/nixos-artwork/master/wallpapers/nix-wallpaper-nineish-catppuccin-mocha.png";
          hash = "sha256-zlYqSid5Q1L5sUrAcvR+7aN2jImiuoR9gygBRk8x9Wo=";
        };
      in
        lib.generators.toINI {mkSectionName = name: name;} {
          "Greeter][Wallpaper][org.kde.image][General".Image = "file://${wallpaper-image}";
        };
    };

    programs = {
      chromium.extensions = ["cimiefiiaegbelhefglklhhakcgmhkai"];
      kdeconnect.enable = true;
    };
    xdg.mime.defaultApplications."inode/directory" = ["org.kde.dolphin.desktop"];

    persist = {
      directories = ["/var/lib/plasmalogin"];
      userDirs = [
        ".config/dolphin"
        ".config/session"
        ".config/kdeconnect"

        ".config/akonadi"
        ".config/libaccounts-glib"
        ".config/signond"

        ".local/share/dolphin"
        ".local/share/kwalletd"
        ".local/share/kscreen"
        ".local/share/kactivitymanagerd"
        ".local/share/kdeconnect"

        ".local/share/akonadi"
        ".local/share/accounts"
        ".local/share/korganizer"
        ".local/share/merkuro"
        ".local/share/signon"
      ];
      kdeUserFiles = [
        ".config/kwinrc"
        ".config/kdeglobals"
        ".config/kwalletrc"
        ".config/ksmserverrc"
        ".config/kscreenlockerrc"
        ".config/ksplashrc"
        ".config/plasmashellrc"
        ".config/plasmashellstaterc"
        ".config/kwinoutputconfig.json"

        ".config/korganizerrc"
        ".config/merkurocalendarrc"

        ".local/state/plasmasessionrestorestaterc"
        ".local/state/kwinstaterc"
        ".local/state/plasmashellstaterc"
        ".local/state/dolphinstaterc"
        # This file doesn't play nice with impermanence and plasma-manager
        # ".config/plasma-org.kde.plasma.desktop-appletsrc";
      ];
    };
  };
}
