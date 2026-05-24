{
  flake.nixosModules.builder = {
    #TODO(max): This module is not complete. It is meant to declaratively create a remote builder.
    users.users.nixremote = {
      isNormalUser = true;

      group = "users";
      extraGroups = [];

      hashedPassword = "!";
      openssh.authorizedKeys.keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMh97+2Z+enIYqz/OPrzjvLfD5wcrYSX+QXDh45qjZDN"];
    };
  };
}
