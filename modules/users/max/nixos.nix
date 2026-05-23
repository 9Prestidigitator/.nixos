{
  flake.userModules.max.nixosModule = {
    users.users.max = {
      isNormalUser = true;
      extraGroups = ["wheel" "audio" "rtkit" "realtime" "uinput" "libvirtd" "cdrom"];
      initialPassword = "nixos";
      hashedPasswordFile = "/persist/passwds/max";
    };

    services.syncthing = {
      user = "max";
      dataDir = "/home/max";
      # key = "${config.sops.secrets."syncthing/key".path}";
      # cert = "${config.sops.secrets."syncthing/cert".path}";
    };

    persist = {
      userDirs = [".nixos"];
    };
  };
}
