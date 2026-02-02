{
  users.users.max = {
    isNormalUser = true;
    extraGroups = ["wheel" "audio" "rtkit" "realtime" "uinput" "libvirtd" "cdrom"];
    openssh.authorizedKeys.keys = [
      # papyr
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIE+gNhwiI6VWUfLepEQJgtob1G3IiJNckD5R5HkRfhE2"
      # book
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPSkPOBCXRRKK/4NKlwdGB0zVFZjlfwE9wNeercfVDGX"
      # FONE
      "ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBIE7a6cld/4ZWzzQT70YA/DWgt7lVf9NcWTqOdDi58onE8qrwjoH7PkmY8Ygd5HJQT0/a2jXPhnq7cCEHFtPCPk="

      # distributed builds
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIF1csWcxfrSn9WUxmkzsP5p1b1Ke38MgI1mOFdz8hnV4"
    ];
  };

  services.syncthing = {
    enable = true;
    openDefaultPorts = true;
    user = "max";
    dataDir = "/home/max";
  };

  home-manager.users."max" = ./home.nix;
}
