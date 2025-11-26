{
  users.users.max = {
    isNormalUser = true;
    extraGroups = ["wheel" "audio" "realtime" "uinput"]; # Enable ‘sudo’ for the user.
  };
}
