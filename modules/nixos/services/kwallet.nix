{self, ...}: {
  flake.nixosModules.kde-wallet = {
    lib,
    pkgs,
    ...
  }: let
    kwriteconfig = lib.getExe' pkgs.kdePackages.kconfig "kwriteconfig6";
    selectKdeWallet = pkgs.writeShellScript "select-kde-wallet" ''
      ${kwriteconfig} --file kwalletrc --group Wallet --key Enabled --type bool true
      ${kwriteconfig} --file kwalletrc --group Wallet --key apiEnabled --type bool true
      ${kwriteconfig} --file kwalletrc --group KSecretD --key Enabled --type bool true
      ${kwriteconfig} --file kwalletrc --group org.freedesktop.secrets --key apiEnabled --type bool true
    '';
  in {
    imports = [self.nixosModules.secret-service];

    secretService.provider = "kde-wallet";

    services = {
      gnome.gnome-keyring.enable = lib.mkForce false;
      dbus.packages = [pkgs.kdePackages.kwallet];
    };

    environment = {
      systemPackages = with pkgs.kdePackages; [
        kwallet
        kwalletmanager
        signon-kwallet-extension
      ];
      etc."xdg/kwalletrc".text = lib.generators.toINI {} {
        Wallet = {
          Enabled = true;
          apiEnabled = true;
        };
        KSecretD.Enabled = true;
        "org.freedesktop.secrets".apiEnabled = true;
      };
    };

    xdg.portal.extraPortals = [pkgs.kdePackages.kwallet];

    # Keep mutable per-user KWallet settings aligned with the system-level
    # provider selection before the graphical session starts.
    systemd.user.services.select-secret-service-provider = {
      description = "Select KWallet as the Secret Service provider";
      wantedBy = ["graphical-session-pre.target"];
      before = ["graphical-session-pre.target"];
      serviceConfig = {
        Type = "oneshot";
        ExecStart = selectKdeWallet;
        RemainAfterExit = true;
      };
    };

    persist = {
      userDirs = [".local/share/kwalletd"];
      kdeUserFiles = [".config/kwalletrc"];
    };
  };
}
