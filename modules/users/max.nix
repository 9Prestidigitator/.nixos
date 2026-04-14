{inputs, ...}: {
  flake.nixosModules.max = {config, ...}: {
    imports = [inputs.sops-nix.nixosModules.sops];

    users.users.max = {
      isNormalUser = true;
      extraGroups = ["wheel" "audio" "rtkit" "realtime" "uinput" "libvirtd" "cdrom"];
    };

    services.syncthing = {
      user = "max";
      dataDir = "/home/max";
      # key = "${config.sops.secrets."syncthing/key".path}";
      # cert = "${config.sops.secrets."syncthing/cert".path}";
    };

    programs.ssh.extraConfig = ''
      Host github.com
        HostName github.com
        User git
        IdentityFile ${config.sops.secrets."ssh/gh".path}
        IdentitiesOnly yes
    '';

    sops = {
      age.keyFile = "/home/max/.config/sops/age/keys.txt";
      secrets = {
        "ssh/gh" = {
          owner = config.users.users.max.name;
          group = config.users.users.max.group;
          mode = "0600";
        };
        "ssh/ink" = {
          owner = config.users.users.max.name;
          group = config.users.users.max.group;
          mode = "0600";
        };
        "ssh/papyr" = {
          owner = config.users.users.max.name;
          group = config.users.users.max.group;
          mode = "0600";
        };
        "ssh/surface" = {
          owner = config.users.users.max.name;
          group = config.users.users.max.group;
          mode = "0600";
        };
        "ssh/cardboard" = {
          owner = config.users.users.max.name;
          group = config.users.users.max.group;
          mode = "0600";
        };
        "ssh/builders/ink" = {};
        "wg0/interface-key" = {};
        "wg0/peer-key" = {};
        "mullvad" = {
          owner = config.users.users.max.name;
          group = config.users.users.max.group;
          mode = "0600";
        };
        "syncthing/key" = {
          owner = config.users.users.max.name;
          group = config.users.users.max.group;
          mode = "0600";
        };
        "syncthing/perm" = {
          owner = config.users.users.max.name;
          group = config.users.users.max.group;
          mode = "0600";
        };
      };
    };
  };

  flake.homeModules.max = {lib, ...}: {
    programs.git = {
      settings = {
        url."ssh://git@github.com".insteadOf = "https://github.com";
        user = {
          name = "9Prestidigitator";
          email = "9Prestidigitator@gmail.com";
        };
      };
    };

    home.activation.ensureNotesDir = lib.hm.dag.entryAfter ["writeBoundary"] ''mkdir -p "$HOME/notes"'';

    services.mpd = {
      enable = true;
      musicDirectory = "/home/max/Music";
      network.listenAddress = "any";
      extraConfig = ''
        audio_output {
          type "pipewire"
          name "PipeWire"
        }
      '';
    };
  };
}
