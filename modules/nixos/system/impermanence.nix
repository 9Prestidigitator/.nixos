{inputs, ...}: {
  flake.nixosModules.impermanence = {
    config,
    lib,
    pkgs,
    ...
  }: let
    # normalizePersistFile = file:
    #   if builtins.isString file
    #   then {
    #     filePath = file;
    #     persistentStoragePath = config.persist.root;
    #   }
    #   else {
    #     filePath = file.file or file.filePath;
    #     persistentStoragePath = file.persistentStoragePath or config.persist.root;
    #   };
    # persistedFiles = map normalizePersistFile config.persist.files;
    # adoptPersistedFile = {
    #   filePath,
    #   persistentStoragePath,
    # }: ''
    #   adopt_persisted_file \
    #     ${lib.escapeShellArg filePath} \
    #     ${lib.escapeShellArg "${persistentStoragePath}${filePath}"}
    # '';

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

    persist = {
      directories = [
        "/etc/NetworkManager/system-connections"
        "/var/lib/bluetooth"
        "/var/lib/nixos"
        "/var/lib/systemd"
        "/var/lib/systemd/timers"
        "/var/lib/NetworkManager"
        "/var/db/sudo"
      ];
      files = [
        "/etc/machine-id"
        "/etc/ssh/ssh_host_ed25519_key"
        "/etc/ssh/ssh_host_ed25519_key.pub"
        "/etc/ssh/ssh_host_rsa_key"
        "/etc/ssh/ssh_host_rsa_key.pub"
      ];
    };

    environment.persistence."/persist" = {
      hideMounts = true;
      directories = lib.unique config.persist.directories;
      files = lib.unique config.persist.files;
      users = userPersistence;
    };

    # system.activationScripts = lib.mkIf (persistedFiles != []) {
    #   adoptExistingPersistedFiles = {
    #     deps = ["createPersistentStorageDirs"];
    #     text = ''
    #       adopt_persisted_file() {
    #         local source="$1"
    #         local target="$2"
    #         if ${pkgs.util-linux}/bin/findmnt "$source" >/dev/null 2>&1; then
    #           return
    #         fi
    #         if [[ ! -e "$target" && -s "$source" ]]; then
    #           ${pkgs.coreutils}/bin/mkdir -p "$(${pkgs.coreutils}/bin/dirname "$target")"
    #           ${pkgs.coreutils}/bin/cp -a "$source" "$target"
    #         fi
    #         if [[ -e "$target" && -e "$source" && -s "$source" ]]; then
    #           ${pkgs.util-linux}/bin/mount --bind "$target" "$source"
    #         fi
    #       }
    #       ${lib.concatMapStrings adoptPersistedFile persistedFiles}
    #     '';
    #   };
    #
    #   persist-files.deps = lib.mkAfter ["adoptExistingPersistedFiles"];
    # };

  };
}
