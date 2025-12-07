{
  users.users.max = {
    isNormalUser = true;
    extraGroups = ["wheel" "audio" "rtkit" "realtime" "uinput" "libvirtd" "cdrom"];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINyAW3sKgu62YpcHJrV1wKaBB1Ck+Y2qAbGyW2TZA+Yq"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOyVUMmHaCovbd5BmyTkQ0MVReUng8Aktatjf0XAJDRp"
    ];
  };
}
