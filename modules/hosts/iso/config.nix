{
  flake.nixosModules.iso = {
    pkgs,
    lib,
    ...
  }: {
    host.name = "iso";
    system.stateVersion = "26.05";

    isoImage.isoName = "nixos-installer.iso";

    boot.supportedFilesystems = lib.mkForce [
      "btrfs"
      "ext4"
      "vfat"
      "xfs"
      "ntfs"
      "cifs"
    ];

    systemd.services = {
      unlock-iso-secrets = {
        description = "Unlock LUKS secrets partition for ISO sops-nix";

        wantedBy = ["multi-user.target"];
        before = ["sops-nix.service"];

        serviceConfig = {
          Type = "oneshot";
          RemainAfterExit = true;
        };

        path = with pkgs; [
          cryptsetup
          util-linux
          coreutils
        ];

        script = ''
          set -euo pipefail

          mkdir -p /etc/sops/age
          tmpmnt=/run/iso-secrets-test
          mkdir -p "$tmpmnt"

          if ! mountpoint -q /etc/sops/age; then
            found=0
            for dev in $(blkid -t TYPE=crypto_LUKS -o device); do
              echo "Trying LUKS device $dev"

              # If a stale mapper exists, close it first.
              if [ -e /dev/mapper/iso-secrets ]; then
                cryptsetup close iso-secrets || true
              fi

              if cryptsetup open "$dev" iso-secrets; then
                if mount /dev/mapper/iso-secrets "$tmpmnt"; then
                  if [ -f "$tmpmnt/keys.txt" ]; then
                    echo "Found ISO secrets partition on $dev"
                    umount "$tmpmnt"
                    mount /dev/mapper/iso-secrets /etc/sops/age
                    found=1
                    break
                  fi
                  umount "$tmpmnt"
                fi
                cryptsetup close iso-secrets || true
              fi
            done

            if [ "$found" != 1 ]; then
              echo "Could not find a LUKS partition containing keys.txt"
              exit 1
            fi
          fi

          if [ ! -f /etc/sops/age/keys.txt ]; then
            echo "Missing /etc/sops/age/keys.txt after mounting secrets partition"
            exit 1
          fi

          chmod 0700 /etc/sops/age
          chmod 0400 /etc/sops/age/keys.txt
        '';
      };

      sops-nix = {
        requires = ["unlock-iso-secrets.service"];
        after = ["unlock-iso-secrets.service"];
      };
    };
  };
}
