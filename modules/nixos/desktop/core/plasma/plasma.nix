{inputs, self, ...}: {
  flake.nixosModules.plasma = {
    pkgs,
    lib,
    ...
  }: let
    plasmalogin-kcminputrc = pkgs.writeText "plasmalogin-kcminputrc" ''
      [Keyboard]
      NumLock=0
    '';
  in {
    services = {
      desktopManager.plasma6.enable = true;
      displayManager.plasma-login-manager.enable = true;

      sunshine = {
        autoStart = true;
        settings.capture = "kwin";
      };
    };

    environment = {
      systemPackages = with pkgs.kdePackages; [
        krfb
        kscreen
        kio-extras
        karousel
        dynamic-workspaces
        self.packages.${pkgs.stdenv.hostPlatform.system}.kwin-zones
        akonadi
        akonadi-contacts
        akonadi-calendar
        kcontacts
        kdepim-runtime
        kaccounts-integration
        kaccounts-providers
        korganizer
        merkuro
        inputs.kwin-effects-glass.packages.${pkgs.stdenv.hostPlatform.system}.default
        inputs.kwin-effects-better-blur-dx.packages.${pkgs.stdenv.hostPlatform.system}.default
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

    systemd.tmpfiles.rules = [
      "d /var/lib/plasmalogin/.config 0755 plasmalogin plasmalogin -"
      "d /var/lib/plasmalogin/.config/kdedefaults 0755 plasmalogin plasmalogin -"
      "L+ /var/lib/plasmalogin/.config/kdedefaults/kcminputrc - - - - ${plasmalogin-kcminputrc}"
    ];

    programs = {
      chromium.extensions = ["cimiefiiaegbelhefglklhhakcgmhkai"];
      kdeconnect.enable = true;
    };

    xdg.portal.enable = true;

    persist = {
      directories = ["/var/lib/plasmalogin"];
      userDirs = [
        ".config/session"
        ".config/kdeconnect"

        ".config/akonadi"
        ".config/libaccounts-glib"
        ".config/signond"

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
        ".config/plasmarc"
        ".config/ksmserverrc"
        ".config/kscreenlockerrc"
        ".config/ksplashrc"
        ".config/plasmashellrc"
        ".config/kactivitymanagerdrc"
        ".config/kactivitymanagerd-pluginsrc"
        ".config/kwinoutputconfig.json"

        ".config/korganizerrc"
        ".config/merkurocalendarrc"

        ".local/state/plasmasessionrestorestaterc"
        ".local/state/kwinstaterc"
        ".local/state/plasmashellstaterc"
        # This file doesn't play nice with impermanence and plasma-manager
        # ".config/plasma-org.kde.plasma.desktop-appletsrc";
      ];
    };
  };
}
