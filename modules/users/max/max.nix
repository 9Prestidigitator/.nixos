{
  flake.nixosModules.max = {config, ...}: {
    users.users.max = {
      isNormalUser = true;
      extraGroups = ["wheel" "audio" "rtkit" "realtime" "uinput" "libvirtd" "cdrom"];
    };

    services.syncthing = {
      user = "max";
      dataDir = "/home/max";
      # key = "${config.sops.secrets."syncthing/key".path}";
      # cert = "${config.sops.secrets."syncthing/cert".path}";
    };

    sops = {
      age.keyFile = "/home/max/.config/sops/age/keys.txt";
      secrets = {
        "ssh/ink" = {
          owner = config.users.users.max.name;
          group = config.users.users.max.group;
          mode = "0600";
        };
        "ssh/papyr" = {
          owner = config.users.users.max.name;
          group = config.users.users.max.group;
          mode = "0600";
        };
        "ssh/surface" = {
          owner = config.users.users.max.name;
          group = config.users.users.max.group;
          mode = "0600";
        };
        "ssh/cardboard" = {
          owner = config.users.users.max.name;
          group = config.users.users.max.group;
          mode = "0600";
        };
        "wg0/private-key" = {};
        "wg0/peer-preshared-key" = {};
        "mullvad" = {
          owner = config.users.users.max.name;
          group = config.users.users.max.group;
          mode = "0600";
        };
        "syncthing/key" = {
          owner = config.users.users.max.name;
          group = config.users.users.max.group;
          mode = "0600";
        };
        "syncthing/perm" = {
          owner = config.users.users.max.name;
          group = config.users.users.max.group;
          mode = "0600";
        };
      };
    };

    home-manager.extraSpecialArgs = {
      sshGhKeyPath = config.sops.secrets."ssh/gh".path;
    };
  };
}
