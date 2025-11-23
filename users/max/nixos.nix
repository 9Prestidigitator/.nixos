{
  users.users.max = {
    isNormalUser = true;
    extraGroups = ["wheel" "audio" "realtime"]; # Enable ‘sudo’ for the user.
  };
}
