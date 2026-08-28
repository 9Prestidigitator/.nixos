{self, ...}: {
  flake.nixosModules.gnome-keyring = {
    lib,
    pkgs,
    ...
  }: {
    imports = [self.nixosModules.secret-service];

    secretService.provider = "gnome-keyring";

    services.gnome.gnome-keyring.enable = lib.mkForce true;

    programs.seahorse.enable = true;

    environment.etc."xdg/kwalletrc".text = lib.generators.toINI {} {
      KSecretD.Enabled = false;
    };

    # A mutable user kwalletrc takes precedence over /etc/xdg/kwalletrc.
    # Reassert the selected provider before each graphical session.
    systemd.user.services.select-secret-service-provider = {
      description = "Select GNOME Keyring as the Secret Service provider";
      wantedBy = ["graphical-session-pre.target"];
      before = ["graphical-session-pre.target"];
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "${lib.getExe' pkgs.kdePackages.kconfig "kwriteconfig6"} --file kwalletrc --group KSecretD --key Enabled --type bool false";
        RemainAfterExit = true;
      };
    };

    persist.userDirs = [".local/share/keyrings"];
  };
}
