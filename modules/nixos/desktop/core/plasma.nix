{inputs, ...}: {
  flake.nixosModules.plasma = {
    pkgs,
    lib,
    ...
  }: {
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
        dolphin
        kio-extras
        karousel
        dynamic-workspaces
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

    programs = {
      chromium.extensions = ["cimiefiiaegbelhefglklhhakcgmhkai"];
      kdeconnect.enable = true;
    };

    xdg = {
      portal.enable = true;
      mime.defaultApplications."inode/directory" = ["org.kde.dolphin.desktop"];
    };

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
        ".local/state/dolphinstaterc"
        # This file doesn't play nice with impermanence and plasma-manager
        # ".config/plasma-org.kde.plasma.desktop-appletsrc";
      ];
    };

    # Workaround for NixOS/nixpkgs#126590 — "excessively long environment
    # variables in KDE Plasma".
    #
    # On NixOS, plasma-workspace's Qt wrapper prefixes XDG_DATA_DIRS with the
    # share/ directory of every package in its closure. The result is an
    # XDG_DATA_DIRS of roughly 18 KB with heavy duplication, inherited by every
    # process the session spawns. Because applications stat every entry in that
    # list when looking up .desktop files, icons, and mime data at startup, this
    # shows up as everything in the session feeling slow to launch — and it is
    # far worse on storage with high per-operation latency, such as a VM disk.
    #
    # The fix,
    # https://github.com/NixOS/nixpkgs/issues/126590#issuecomment-3194531220:
    # build a single derivation that merges the contents of all those share/
    # directories into one, strip the wrapper's XDG_DATA_DIRS injection, and
    # point it at the merged directory instead. XDG_DATA_DIRS goes from ~18 KB
    # and hundreds of entries down to two.
    #
    # COST: this rebuilds plasma-workspace from source.
    nixpkgs.overlays = lib.singleton (
      final: prev: {
        kdePackages =
          prev.kdePackages
          // {
            plasma-workspace = let
              basePkg = prev.kdePackages.plasma-workspace;

              xdgdataPkg = prev.stdenv.mkDerivation {
                name = "${basePkg.name}-xdgdata";
                buildInputs = [basePkg];
                dontUnpack = true;
                dontFixup = true;
                dontWrapQtApps = true;
                installPhase = ''
                  mkdir -p $out/share
                  ( IFS=:
                    for DIR in $XDG_DATA_DIRS; do
                      if [[ -d "$DIR" ]]; then
                        cp -r $DIR/. $out/share/
                        chmod -R u+w $out/share
                      fi
                    done
                  )
                '';
              };
            in
              basePkg.overrideAttrs {
                preFixup = ''
                  for index in "''${!qtWrapperArgs[@]}"; do
                    if [[ ''${qtWrapperArgs[$((index+0))]} == "--prefix" ]] && [[ ''${qtWrapperArgs[$((index+1))]} == "XDG_DATA_DIRS" ]]; then
                      unset -v "qtWrapperArgs[$((index+0))]"
                      unset -v "qtWrapperArgs[$((index+1))]"
                      unset -v "qtWrapperArgs[$((index+2))]"
                      unset -v "qtWrapperArgs[$((index+3))]"
                    fi
                  done
                  qtWrapperArgs=("''${qtWrapperArgs[@]}")
                  qtWrapperArgs+=(--prefix XDG_DATA_DIRS : "${xdgdataPkg}/share")
                  qtWrapperArgs+=(--prefix XDG_DATA_DIRS : "$out/share")
                '';
              };
          };
      }
    );
  };
}
