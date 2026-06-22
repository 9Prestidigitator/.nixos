{
  flake.nixosModules.builder = {pkgs, ...}: {
    users.users.nixremote = {
      isSystemUser = true;

      group = "users";
      extraGroups = [];

      shell = pkgs.bashInteractive;
      hashedPassword = "!";
      openssh.authorizedKeys.keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMh97+2Z+enIYqz/OPrzjvLfD5wcrYSX+QXDh45qjZDN"];
    };
  };
}
