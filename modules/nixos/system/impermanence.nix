{inputs, ...}: {
  flake.nixosModules.impermanence = {
    imports = [inputs.impermanence.nixosModules.impermanence];
    environment.persistence."/persist" = {
      hideMounts = true;

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
  };
}
