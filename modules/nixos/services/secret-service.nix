{
  flake.nixosModules.secret-service = {
    config,
    lib,
    pkgs,
    ...
  }: let
    cfg = config.secretService;
    isGnomeKeyring = cfg.provider == "gnome-keyring";
    isKdeWallet = cfg.provider == "kde-wallet";

    portal =
      if isGnomeKeyring
      then "gnome-keyring"
      else "kwallet";

    pamServices =
      ["login"]
      ++ lib.optional config.services.greetd.enable "greetd"
      ++ lib.optional config.services.displayManager.sddm.enable "sddm"
      ++ lib.optional config.services.displayManager.ly.enable "ly"
      ++ lib.optional config.services.displayManager.gdm.enable "gdm-password";

    pamConfig = lib.genAttrs pamServices (_: {
      enableGnomeKeyring = lib.mkForce isGnomeKeyring;
      kwallet.enable = lib.mkForce isKdeWallet;
    });
  in {
    options.secretService.provider = lib.mkOption {
      type = lib.types.nullOr (lib.types.enum ["gnome-keyring" "kde-wallet"]);
      default = null;
      description = ''
        Secret Service provider to use independently of the selected desktop
        environment or compositor. Prefer importing the gnome-keyring or
        kde-wallet module instead of setting this option directly.
      '';
    };

    config = lib.mkIf (cfg.provider != null) {
      security.pam.services = pamConfig;
      services.passSecretService.enable = lib.mkForce false;

      # Desktop-specific files take precedence over portals.conf. Keep
      # each desktop's normal portal ordering while pinning Secret.
      xdg.portal.config = lib.mkMerge [
        {
          common = {
            default = lib.mkDefault "*";
            "org.freedesktop.impl.portal.Secret" = lib.mkForce portal;
          };
        }
        (lib.mkIf config.programs.niri.enable {
          niri."org.freedesktop.impl.portal.Secret" = lib.mkForce portal;
        })
        (lib.mkIf config.services.desktopManager.plasma6.enable {
          kde = {
            default = lib.mkDefault ["kde" "gtk"];
            "org.freedesktop.impl.portal.Secret" = lib.mkForce portal;
          };
        })
        (lib.mkIf config.services.desktopManager.gnome.enable {
          gnome = {
            default = lib.mkDefault ["gnome" "gtk"];
            "org.freedesktop.impl.portal.Secret" = lib.mkForce portal;
          };
        })
        {
          # These compositors use their own desktop-specific portal files,
          # which take precedence over the common portals.conf fallback.
          umbriel = {
            default = lib.mkDefault ["umbriel" "gtk"];
            "org.freedesktop.impl.portal.Secret" = lib.mkForce portal;
          };
          wlroots = {
            default = lib.mkDefault ["wlr" "gtk"];
            "org.freedesktop.impl.portal.Secret" = lib.mkForce portal;
          };
          i3 = {
            default = lib.mkDefault ["gtk"];
            "org.freedesktop.impl.portal.Secret" = lib.mkForce portal;
          };
        }
      ];
    };
  };
}
