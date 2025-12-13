{
  lib,
  config,
  ...
}: {
  users.users.max = {
    isNormalUser = true;
    extraGroups = ["wheel" "audio" "rtkit" "realtime" "uinput" "libvirtd" "cdrom"];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIE+gNhwiI6VWUfLepEQJgtob1G3IiJNckD5R5HkRfhE2"
      "ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBIE7a6cld/4ZWzzQT70YA/DWgt7lVf9NcWTqOdDi58onE8qrwjoH7PkmY8Ygd5HJQT0/a2jXPhnq7cCEHFtPCPk="
    ];
  };

  home-manager.sharedModules = [
    {
      programs.git = {
        settings.user = {
          name = "9Prestidigitator";
          email = "9Prestidigitator@gmail.com";
        };
      };
      home.activation.syncNvimDotfiles = lib.hm.dag.entryAfter ["writeBoundary"] ''
        $DRY_RUN_CMD ${
          syncRepo {
            url = "https://github.com/9Prestidigitator/nvim.git";
            destination = "${config.home.homeDirectory}/.config/nvim";
          }
        }
      '';
    }
  ];
}
