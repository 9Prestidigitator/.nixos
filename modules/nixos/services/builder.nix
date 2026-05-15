{
  flake.nixosModules.builder = {
    users.users.nixremote = {
      home = "/home/nixremote";
      group = "users";
      extraGroups = [ ];
      hashedPassword = "!";
      openssh.authorizedKeys.keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMh97+2Z+enIYqz/OPrzjvLfD5wcrYSX+QXDh45qjZDN"];
    };
  };
}
