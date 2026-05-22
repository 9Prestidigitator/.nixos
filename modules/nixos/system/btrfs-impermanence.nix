{
  flake.nixosModules.btrfs-impermanence = {
    config,
    lib,
    pkgs,
    ...
  }: let
    cfg = config.impermanence.btrfs.rollbackRoot;

    btrfs = "${pkgs.btrfs-progs}/bin/btrfs";
    cut = "${pkgs.coreutils}/bin/cut";
    date = "${pkgs.coreutils}/bin/date";
    find = "${pkgs.findutils}/bin/find";
    mkdir = "${pkgs.coreutils}/bin/mkdir";
    mount = "${config.boot.initrd.systemd.package.util-linux}/bin/mount";
    mv = "${pkgs.coreutils}/bin/mv";
    stat = "${pkgs.coreutils}/bin/stat";
    umount = "${config.boot.initrd.systemd.package.util-linux}/bin/umount";
  in {
    options.impermanence.btrfs.rollbackRoot = {
      enable = lib.mkEnableOption "Btrfs root subvolume rollback during initrd";

      device = lib.mkOption {
        type = lib.types.str;
        default = "/dev/mapper/crypted-root";
        description = "Btrfs filesystem device that contains the root subvolume.";
      };

      rootSubvolume = lib.mkOption {
        type = lib.types.str;
        default = "@root";
        description = "Btrfs subvolume used as the mounted root filesystem.";
      };

      oldRootsSubvolume = lib.mkOption {
        type = lib.types.str;
        default = "old_roots";
        description = "Directory or subvolume used to store previous root subvolumes.";
      };

      retentionDays = lib.mkOption {
        type = lib.types.ints.positive;
        default = 30;
        description = "Delete old root subvolumes older than this many days.";
      };

      after = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = ["systemd-cryptsetup@crypted\\x2droot.service"];
        description = "Initrd systemd units that must finish before root rollback runs.";
      };
    };

    config = lib.mkIf cfg.enable {
      boot.initrd.systemd.services.rollback-root = {
        description = "Rollback Btrfs root subvolume";
        wantedBy = ["initrd.target"];
        after = cfg.after;
        before = ["sysroot.mount"];

        unitConfig.DefaultDependencies = "no";
        serviceConfig.Type = "oneshot";

        script = ''
          set -euo pipefail

          tmp=/btrfs_tmp
          root_subvolume=${lib.escapeShellArg cfg.rootSubvolume}
          old_roots=${lib.escapeShellArg cfg.oldRootsSubvolume}

          cleanup() {
            ${umount} "$tmp" >/dev/null 2>&1 || true
          }
          trap cleanup EXIT

          ${mkdir} -p "$tmp"
          ${mount} -t btrfs -o subvolid=5 ${lib.escapeShellArg cfg.device} "$tmp"

          if [[ -e "$tmp/$root_subvolume" ]]; then
            ${mkdir} -p "$tmp/$old_roots"
            mtime="$(${stat} -c %Y "$tmp/$root_subvolume")"
            timestamp="$(${date} --date="@$mtime" "+%Y-%m-%d_%H:%M:%S")"
            ${mv} "$tmp/$root_subvolume" "$tmp/$old_roots/$timestamp"
          fi

          delete_subvolume_recursively() {
            while IFS= read -r subvolume; do
              delete_subvolume_recursively "$tmp/$subvolume"
            done < <(${btrfs} subvolume list -o "$1" | ${cut} -f 9- -d ' ')

            ${btrfs} subvolume delete "$1"
          }

          if [[ -d "$tmp/$old_roots" ]]; then
            while IFS= read -r old_root; do
              delete_subvolume_recursively "$old_root"
            done < <(${find} "$tmp/$old_roots" -mindepth 1 -maxdepth 1 -mtime +${toString cfg.retentionDays})
          fi

          ${btrfs} subvolume create "$tmp/$root_subvolume"
        '';
      };
    };
  };
}
