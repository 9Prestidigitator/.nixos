{
  flake.nixosModules.wg0 = {config, ...}: {
    sops = {
      secrets = {
        "wg0/private-key" = {
          defaultSopsFile = ../../../secrets/wg0.yaml;
          owner = "root";
          group = "root";
          mode = "0400";
        };
        "wg0/peer-preshared-key" = {
          defaultSopsFile = ../../../secrets/wg0.yaml;
          owner = "root";
          group = "root";
          mode = "0400";
        };
      };
    };

    networking.wg-quick.interfaces.wg0 = {
      autostart = false;
      address = ["10.177.136.3/24"];
      dns = ["1.1.1.1" "1.0.0.1"];
      privateKeyFile = "${config.sops.secrets."wg0/private-key".path}";
      peers = [
        {
          publicKey = "v0fbXMD0qSknF/lxTGf0iY0xs1ffm1Fm6igknJQKi10=";
          presharedKeyFile = "${config.sops.secrets."wg0/peer-preshared-key".path}";
          endpoint = "108.18.94.91:51820";
          allowedIPs = ["0.0.0.0/0"];
          persistentKeepalive = 25;
        }
      ];
    };
  };
}
