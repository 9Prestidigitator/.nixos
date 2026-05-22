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
          lib.unique (config.persist.userDirs ++ (hmCfg.persist.directories or []));
        files =
          lib.unique (config.persist.userFiles ++ (hmCfg.persist.files or []));
      })
      normalUsers;
  in {
    imports = [inputs.impermanence.nixosModules.impermanence];

    fileSystems."/".neededForBoot = true;
    fileSystems."/nix".neededForBoot = true;
    fileSystems."/persist".neededForBoot = true;

    users.users = {
      root.initialPassword = "nixos";
      max.initialPassword = "nixos";
    };

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
      directories = lib.unique config.persist.directories;
      files = lib.unique config.persist.files;
      users = userPersistence;
    };
  };
}
