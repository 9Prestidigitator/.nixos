{
  users.users.max = {
    isNormalUser = true;
    createHome = true;
    extraGroups = ["wheel" "audio" "realtime" "uinput" "libvirtd"];
  };
}
