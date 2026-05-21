{inputs, ...}: {
  flake.nixosModules.impermanence = {
    config,
    lib,
    ...
  }: let
    normalUsers =
      lib.filterAttrs
      (_name: user: user.isNormalUser or false)
      config.users.users;
    hmUsers = config.home-manager.users or {};
    userPersistence =
      lib.mapAttrs (name: _user: let
        hmCfg = hmUsers.${name} or {};
      in {
        directories =
          config.persist.userDirs ++ (hmCfg.persist.directories or []);
        files =
          config.persist.userFiles ++ (hmCfg.persist.files or []);
      })
      normalUsers;
  in {
    imports = [inputs.impermanence.nixosModules.impermanence];
    persist = {
      directories = [
        "/etc/NetworkManager/system-connections"
        "/var/lib/bluetooth"
        "/var/lib/nixos"
        "/var/lib/systemd"
        "/var/lib/NetworkManager"
        "/var/db/sudo"
      ];
      files = [
        "/etc/machine-id"
        "/etc/ssh/ssh_host_ed25519_key"
        "/etc/ssh/ssh_host_ed25519_key.pub"
      ];
    };
    environment.persistence."/persist" = {
      hideMounts = true;
      directories = config.persist.directories;
      files = config.persist.files;
      users = userPersistence;
    };
  };
}
