{inputs, ...}: {
  flake.nixosModules.iso = {
    pkgs,
    lib,
    ...
  }: {
    host.name = "iso";
    system.stateVersion = "26.05";
    isoImage.isoName = "nixos-installer.iso";

    environment.systemPackages = with pkgs; [neovim];

    boot.supportedFilesystems = lib.mkForce [
      "btrfs"
      "ext4"
      "vfat"
      "xfs"
      "ntfs"
      "cifs"
    ];

    # TODO(max): fix this
    systemd.services = {
      unlock-iso-secrets = {
        description = "Unlock LUKS secrets partition for ISO sops-nix";

        wantedBy = ["multi-user.target"];
        before = ["sops-nix.service"];
        requiredBy = ["sops-nix.service"];

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
          mapper=iso-secrets
          keydir=/etc/sops/age
          tmpmnt=/run/iso-secrets-test
          passfile=/run/iso-secrets-passphrase

          mkdir -p "$keydir" "$tmpmnt"
          cleanup() {
            rm -f "$passfile"
          }
          trap cleanup EXIT
          if mountpoint -q "$keydir"; then
            echo "$keydir is already mounted"
            exit 0
          fi

          systemd-ask-password --timeout=0 "Passphrase for ISO secrets LUKS partition:" > "$passfile"
          chmod 0400 "$passfile"
          found=0

          for dev in $(blkid -t TYPE=crypto_LUKS -o device); do
            echo "Trying LUKS device $dev"

            if [ -e "/dev/mapper/$mapper" ]; then
              cryptsetup close "$mapper" || true
            fi

            if cryptsetup open --key-file "$passfile" "$dev" "$mapper"; then
              if mount "/dev/mapper/$mapper" "$tmpmnt"; then
                if [ -f "$tmpmnt/keys.txt" ]; then
                  echo "Found ISO secrets partition on $dev"
                  umount "$tmpmnt"
                  mount "/dev/mapper/$mapper" "$keydir"
                  found=1
                  break
                fi
                umount "$tmpmnt"
              fi
              cryptsetup close "$mapper" || true
            fi
          done

          if [ "$found" != 1 ]; then
            echo "Could not find a LUKS partition containing keys.txt"
            exit 1
          fi

          if [ ! -f "$keydir/keys.txt" ]; then
            echo "Missing $keydir/keys.txt after mounting secrets partition"
            exit 1
          fi

          chmod 0700 "$keydir"
          chmod 0400 "$keydir/keys.txt"
          echo "ISO SOPS age key mounted at $keydir/keys.txt"
        '';
      };

      sops-nix = {
        requires = ["unlock-iso-secrets.service"];
        after = ["unlock-iso-secrets.service"];
      };
    };
  };
}
