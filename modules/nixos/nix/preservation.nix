{inputs, ...}: {
  flake.nixosModules.preservation = {
    config,
    lib,
    ...
  }: let
    persistedUsers =
      lib.filterAttrs
      (name: user:
        (user.isNormalUser or false)
        && !(builtins.elem name config.persist.excludedUsers))
      config.users.users;
    hmUsers = config.home-manager.users or {};

    userPersistence =
      lib.filterAttrs
      (_name: userConfig:
        userConfig.directories != [] || userConfig.files != []) (
        lib.mapAttrs (name: _user: let
          hmCfg = hmUsers.${name} or {};
        in {
          directories = lib.unique (config.persist.userDirs ++ (hmCfg.persist.directories or []));
          files = lib.unique (config.persist.userFiles ++ (hmCfg.persist.files or []));
        })
        persistedUsers
      );

    defaultSystemFiles = [
      {
        file = "/etc/machine-id";
        settings.inInitrd = true;
      }
      # {
      #   file = "/etc/ssh/ssh_host_ed25519_key";
      #   settings = {
      #     how = "symlink";
      #     configureParent = true;
      #   };
      # }
      # {
      #   file = "/etc/ssh/ssh_host_rsa_key";
      #   settings = {
      #     how = "symlink";
      #     configureParent = true;
      #   };
      # }
    ];

    fileSettings =
      lib.listToAttrs
      (map (file: {
          name = file.file;
          value = file.settings;
        })
        defaultSystemFiles);

    toPreservationFile = file: let
      normalized =
        if builtins.isString file
        then {inherit file;}
        else file;
      settings = fileSettings.${normalized.file} or {};
    in
      settings // normalized;
  in {
    imports = [inputs.preservation.nixosModules.preservation];

    fileSystems."/".neededForBoot = true;
    fileSystems."/nix".neededForBoot = true;
    fileSystems.${config.persist.root}.neededForBoot = true;

    persist = {
      directories = [
        "/etc/NetworkManager/system-connections"
        "/etc/ssh"
        "/var/lib/bluetooth"
        "/var/lib/nixos"
        "/var/lib/systemd"
        "/var/lib/systemd/timers"
        "/var/lib/NetworkManager"
        "/var/db/sudo"
      ];
      files = map (file: file.file) defaultSystemFiles;
      userDirs = [
        "Desktop"
        "Documents"
        "Downloads"
        "Music"
        "Pictures"
        "Videos"
        "Projects"
      ];
      userFiles = [".ssh/known_hosts"];
    };

    preservation = {
      enable = lib.mkDefault true;
      preserveAt.${config.persist.root} = {
        commonMountOptions = ["x-gvfs-hide"];
        directories = lib.unique config.persist.directories;
        files = lib.unique (map toPreservationFile config.persist.files);
        users = userPersistence;
      };
    };

    systemd.suppressedSystemUnits = ["systemd-machine-id-commit.service"];

    systemd.services.sops-setup-secrets-after-persistence = lib.mkIf (config.system.activationScripts ? setupSecrets) {
      description = "Set up sops-nix secrets after persistent state is mounted";
      wantedBy = ["sysinit.target"];
      after = ["local-fs.target" "preservation.target"];
      before = ["sysinit.target"];

      unitConfig.DefaultDependencies = "no";
      serviceConfig.Type = "oneshot";

      script = config.system.activationScripts.setupSecrets.text;
    };
  };
}
