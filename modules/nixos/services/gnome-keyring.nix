{self, ...}: {
  flake.nixosModules.gnome-keyring = {
    lib,
    pkgs,
    ...
  }: {
    imports = [self.nixosModules.secret-service];

    secretService.provider = "gnome-keyring";

    services.gnome.gnome-keyring.enable = lib.mkForce true;

    programs = {
      seahorse.enable = true;
      ssh.askPassword = lib.mkForce "${pkgs.seahorse}/libexec/seahorse/ssh-askpass";
    };

    environment.etc."xdg/kwalletrc".text = lib.generators.toINI {} {
      Wallet = {
        Enabled = false;
        apiEnabled = false;
      };
      KSecretD.Enabled = false;
      "org.freedesktop.secrets".apiEnabled = false;
    };

    services.dbus.packages = [
      (pkgs.writeTextDir "share/dbus-1/session.d/disable-kwallet.conf" ''
        <busconfig>
          <policy context="default">
            <deny own="org.kde.kwalletd5"/>
            <deny own="org.kde.kwalletd6"/>
          </policy>
        </busconfig>
      '')
    ];

    security.pam.services.kde.kwallet.enable = lib.mkForce false;

    systemd.user.services.select-secret-service-provider = {
      description = "Select GNOME Keyring as the Secret Service provider";
      wantedBy = ["graphical-session-pre.target"];
      before = ["graphical-session-pre.target"];
      serviceConfig = {
        Type = "oneshot";
        ExecStart = pkgs.writeShellScript "disable-kde-wallet" ''
          kwriteconfig=${lib.getExe' pkgs.kdePackages.kconfig "kwriteconfig6"}
          "$kwriteconfig" --file kwalletrc --group Wallet --key Enabled --type bool false
          "$kwriteconfig" --file kwalletrc --group Wallet --key apiEnabled --type bool false
          "$kwriteconfig" --file kwalletrc --group KSecretD --key Enabled --type bool false
          "$kwriteconfig" --file kwalletrc --group org.freedesktop.secrets --key apiEnabled --type bool false
        '';
        RemainAfterExit = true;
      };
    };

    persist.userDirs = [".local/share/keyrings"];
  };
}
