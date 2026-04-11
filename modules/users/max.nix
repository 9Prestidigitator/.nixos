{
  flake.nixosModules.max = {
    users.users.max = {
      isNormalUser = true;
      extraGroups = ["wheel" "audio" "rtkit" "realtime" "uinput" "libvirtd" "cdrom"];
      openssh.authorizedKeys.keys = [
        # papyr->ink
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIE+gNhwiI6VWUfLepEQJgtob1G3IiJNckD5R5HkRfhE2"
        # FONE->ink
        "ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBIE7a6cld/4ZWzzQT70YA/DWgt7lVf9NcWTqOdDi58onE8qrwjoH7PkmY8Ygd5HJQT0/a2jXPhnq7cCEHFtPCPk="
        ""
      ];
    };
    services.syncthing = {
      user = "max";
      dataDir = "/home/max";
    };
  };

  flake.homeModules.max = {lib, ...}: {
    programs.git = {
      settings.user = {
        name = "9Prestidigitator";
        email = "9Prestidigitator@gmail.com";
      };
    };
    home.activation.ensureNotesDir = lib.hm.dag.entryAfter ["writeBoundary"] ''
      mkdir -p "$HOME/notes"
    '';
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
