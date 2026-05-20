{inputs, ...}: {
  flake.nixosModules.iso = {
    pkgs,
    lib,
    ...
  }: let
    scriptPath = lib.makeBinPath [
      pkgs.coreutils
      pkgs.util-linux
      pkgs.cryptsetup
      pkgs.gnugrep
      pkgs.gawk
      pkgs.findutils
      pkgs.systemd
    ];

    unlockInstallerSecrets = pkgs.writeShellScriptBin "unlock-installer-secrets" ''
      set -euo pipefail
      export PATH="${scriptPath}:$PATH"

      # This should be the LUKS label on the outer encrypted partition.
      # Example: cryptsetup luksFormat --label secret-store /dev/sda3
      LUKS_DEVICE="''${1:-/dev/disk/by-label/secret-store}"

      MAPPER_NAME="secrets_crypt"
      MOUNTPOINT="/mnt/secret-store"

      AGE_KEY_SOURCE="$MOUNTPOINT/keys.txt"
      AGE_KEY_TARGET="/etc/sops/age/keys.txt"

      LOOP_FILE="/run/secrets-loop-device"

      echo "Resolving LUKS device: $LUKS_DEVICE"

      PARTDEV="$(readlink -f "$LUKS_DEVICE")"
      PARTNAME="$(basename "$PARTDEV")"
      DISKNAME="$(lsblk -no PKNAME "$PARTDEV" | head -n1)"
      DISKDEV="/dev/$DISKNAME"

      if [ -z "$DISKNAME" ]; then
        echo "Could not determine parent disk for $PARTDEV" >&2
        exit 1
      fi

      echo "Partition: $PARTDEV"
      echo "Parent disk: $DISKDEV"

      if [ -e "/dev/mapper/$MAPPER_NAME" ]; then
        echo "/dev/mapper/$MAPPER_NAME already exists"
      else
        START="$(cat "/sys/class/block/$PARTNAME/start")"
        SECTORS="$(cat "/sys/class/block/$PARTNAME/size")"
        SECTOR_SIZE="$(cat "/sys/class/block/$DISKNAME/queue/logical_block_size")"

        OFFSET=$(( START * SECTOR_SIZE ))
        SIZE=$(( SECTORS * SECTOR_SIZE ))

        echo "Creating loop device for $PARTDEV"
        echo "  offset: $OFFSET"
        echo "  size:   $SIZE"

        LOOP="$(losetup --find --show --offset "$OFFSET" --sizelimit "$SIZE" "$DISKDEV")"
        echo "$LOOP" > "$LOOP_FILE"

        echo "Opening LUKS container through $LOOP"
        cryptsetup open "$LOOP" "$MAPPER_NAME"
      fi

      mkdir -p "$MOUNTPOINT"

      if ! mountpoint -q "$MOUNTPOINT"; then
        mount "/dev/mapper/$MAPPER_NAME" "$MOUNTPOINT"
      else
        echo "$MOUNTPOINT already mounted"
      fi

      if ! [ -f "$AGE_KEY_SOURCE" ]; then
        echo "Missing age key: $AGE_KEY_SOURCE" >&2
        echo "Expected the key at:"
        echo "  $AGE_KEY_SOURCE"
        exit 1
      fi

      mkdir -p /etc/sops/age
      ln -sfn "$AGE_KEY_SOURCE" "$AGE_KEY_TARGET"
      chmod 0400 "$AGE_KEY_SOURCE"

      echo "Re-running NixOS activation..."
      /run/current-system/activate

      echo
      echo "Secrets should now be available under:"
      echo "  /run/secrets"
    '';

    lockInstallerSecrets = pkgs.writeShellScriptBin "lock-installer-secrets" ''
      set -euo pipefail
      export PATH="${scriptPath}:$PATH"

      MAPPER_NAME="secrets_crypt"
      MOUNTPOINT="/mnt/secret-store"
      LOOP_FILE="/run/secrets-loop-device"

      echo "Removing sops-nix age key symlink..."
      rm -f /etc/sops/age/key.txt

      echo "Removing runtime decrypted secrets..."
      rm -rf /run/secrets

      if mountpoint -q "$MOUNTPOINT"; then
        umount "$MOUNTPOINT"
      fi

      if [ -e "/dev/mapper/$MAPPER_NAME" ]; then
        cryptsetup close "$MAPPER_NAME"
      fi

      if [ -f "$LOOP_FILE" ]; then
        LOOP="$(cat "$LOOP_FILE")"
        losetup -d "$LOOP" 2>/dev/null || true
        rm -f "$LOOP_FILE"
      fi

      echo "Locked."
    '';
  in {
    host.name = "iso";
    system.stateVersion = "25.11";
    isoImage.isoName = "nixos-installer.iso";

    imports = [inputs.sops-nix.nixosModules.sops];

    environment.systemPackages = with pkgs; [
      neovim
      disko
      cryptsetup
      sops
      age
      unlockInstallerSecrets
      lockInstallerSecrets
    ];

    boot.supportedFilesystems = lib.mkForce [
      "iso9660"
      "btrfs"
      "ext4"
      "vfat"
      "xfs"
      "ntfs"
      "cifs"
    ];

    boot.initrd.supportedFilesystems = lib.mkForce [
      "iso9660"
      "btrfs"
      "ext4"
      "vfat"
      "xfs"
      "ntfs"
      "cifs"
    ];
  };
}
