{
  flake.userModules.guest.nixosModule = {
    users.users.guest = {
      isNormalUser = true;
      extraGroups = ["cdrom" "audio" "realtime"];
      initialPassword = "1234";
    };
  };
}
