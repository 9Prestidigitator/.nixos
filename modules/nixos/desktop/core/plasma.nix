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
        inputs.kwin-effects-glass.packages.${pkgs.system}.default
        inputs.kwin-effects-better-blur-dx.packages.${pkgs.system}.default
      ];

      sessionVariables.NIXOS_OZONE_WL = "1";

      etc."plasmalogin.conf".text = let
        wallpaper-image = pkgs.fetchurl {
          url = "https://raw.githubusercontent.com/NixOS/nixos-artwork/master/wallpapers/nix-wallpaper-simple-dark-gray.png";
          hash = "sha256-JaLHdBxwrphKVherDVe5fgh+3zqUtpcwuNbjwrBlAok=";
        };
      in
        lib.generators.toINI {mkSectionName = name: name;} {
          "Greeter][Wallpaper][org.kde.image][General".Image = "file://${wallpaper-image}";
        };
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
      ];
      kdeUserFiles = [
        ".config/kwinrc"
        ".config/kdeglobals"
        ".config/kwalletrc"
        ".config/ksmserverrc"
        ".config/kscreenlockerrc"
        ".config/ksplashrc"
        ".config/kwinoutputconfig.json"
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
