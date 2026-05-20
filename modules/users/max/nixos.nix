{
  flake.userModules.max.nixosModule = {
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
  };
}
