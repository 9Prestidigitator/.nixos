{inputs, ...}: {
  flake.nixosModules.iso = {
    pkgs,
    lib,
    ...
  }: {
    host.name = "iso";
    system.stateVersion = "26.05";

    isoImage.isoName = "nixos-installer.iso";

    environment.systemPackages = [inputs.maxvim.packages.${pkgs.stdenv.hostPlatform.system}.default];

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
          systemd
        ];

        script = ''
          set -euo pipefail

          mkdir -p /etc/sops/age
          tmpmnt=/run/iso-secrets-test
          passfile=/run/iso-secrets-passphrase
          mkdir -p "$tmpmnt"

          cleanup() {
            rm -f "$passfile"
          }
          trap cleanup EXIT
          if ! mountpoint -q /etc/sops/age; then
            found=0

            systemd-ask-password --timeout=0 "Passphrase for ISO secrets LUKS partition:" > "$passfile"
            chmod 0400 "$passfile"

            for dev in $(blkid -t TYPE=crypto_LUKS -o device); do
              echo "Trying LUKS device $dev"
              if [ -e /dev/mapper/iso-secrets ]; then
                cryptsetup close iso-secrets || true
              fi

              if cryptsetup open --key-file "$passfile" "$dev" iso-secrets; then
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
