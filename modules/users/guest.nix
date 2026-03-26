{
  flake.nixosModules.guest = {
    users.users.guest = {
      isNormalUser = true;
      extraGroups = ["cdrom" "audio" "realtime"];
    };
  };
}
