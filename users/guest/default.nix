{
  users.users.guest = {
    isNormalUser = true;
    extraGroups = ["cdrom" "audio" "realtime"];
  };

  home-manager.users."guest" = ./home.nix;
}
