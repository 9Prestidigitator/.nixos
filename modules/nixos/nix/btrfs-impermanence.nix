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

    cleanOldRoots = pkgs.writeShellApplication {
      name = "clean-old-roots";
      runtimeInputs = [
        pkgs.btrfs-progs
        pkgs.coreutils
        pkgs.findutils
        pkgs.gawk
        pkgs.util-linux
      ];
      text = ''
        set -euo pipefail

        device=${lib.escapeShellArg cfg.device}
        old_roots_name=${lib.escapeShellArg cfg.oldRootsSubvolume}
        retention_days=${toString cfg.retentionDays}
        mode=older
        days="$retention_days"
        roots=()

        usage() {
          cat <<EOF
        Usage: clean-old-roots [--older-than DAYS | --all] [OLD_ROOT...]

        Deletes saved Btrfs impermanence roots from $old_roots_name on $device.

        Without OLD_ROOT arguments, deletes roots older than $retention_days days.
        OLD_ROOT arguments are names under $old_roots_name, for example:
          clean-old-roots 2026-05-22_16:09:04

        Options:
          --older-than DAYS  Delete roots older than DAYS days.
          --all              Delete every saved old root.
          -h, --help         Show this help.
        EOF
        }

        while (($#)); do
          case "$1" in
            --older-than)
              if [[ $# -lt 2 || ! "$2" =~ ^[0-9]+$ ]]; then
                echo "--older-than requires a non-negative integer day count" >&2
                exit 2
              fi
              mode=older
              days="$2"
              shift 2
              ;;
            --all)
              mode=all
              shift
              ;;
            -h|--help)
              usage
              exit 0
              ;;
            --)
              shift
              while (($#)); do
                roots+=("$1")
                shift
              done
              ;;
            -*)
              echo "Unknown option: $1" >&2
              usage >&2
              exit 2
              ;;
            *)
              roots+=("$1")
              shift
              ;;
          esac
        done

        if [[ $EUID -ne 0 ]]; then
          echo "clean-old-roots must be run as root." >&2
          exit 1
        fi

        tmp="$(mktemp -d /tmp/btrfs-old-roots.XXXXXX)"
        cleanup() {
          umount "$tmp" >/dev/null 2>&1 || true
          rmdir "$tmp" >/dev/null 2>&1 || true
        }
        trap cleanup EXIT

        mount -t btrfs -o subvolid=5 "$device" "$tmp"
        old_roots_path="$tmp/$old_roots_name"

        if [[ ! -d "$old_roots_path" ]]; then
          echo "No old roots directory found at $old_roots_name on $device."
          exit 0
        fi

        targets=()
        if ((''${#roots[@]})); then
          for root in "''${roots[@]}"; do
            root="''${root#/}"
            if [[ "$root" == */* ]]; then
              echo "Old root names must be direct children of $old_roots_name: $root" >&2
              exit 2
            fi
            targets+=("$old_roots_path/$root")
          done
        elif [[ "$mode" == all ]]; then
          mapfile -t targets < <(find "$old_roots_path" -mindepth 1 -maxdepth 1)
        else
          mapfile -t targets < <(find "$old_roots_path" -mindepth 1 -maxdepth 1 -mtime +"$days")
        fi

        if ((''${#targets[@]} == 0)); then
          echo "No old roots matched."
          exit 0
        fi

        delete_subvolume_recursively() {
          local target="$1"

          if [[ ! -e "$target" ]]; then
            echo "Skipping missing old root: $target" >&2
            return
          fi

          mapfile -t children < <(
            btrfs subvolume list -o "$target" \
              | cut -f 9- -d ' ' \
              | awk '{ print length, $0 }' \
              | sort -rn \
              | cut -f 2- -d ' '
          )

          for child in "''${children[@]}"; do
            if [[ -e "$tmp/$child" ]]; then
              btrfs subvolume delete "$tmp/$child"
            fi
          done

          btrfs subvolume delete "$target"
        }

        for target in "''${targets[@]}"; do
          delete_subvolume_recursively "$target"
        done
      '';
    };
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
      environment.systemPackages = [cleanOldRoots];

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
