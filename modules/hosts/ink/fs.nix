{
  flake.nixosModules.ink = {
    fileSystems = {
      "/mnt/win" = {
        device = "/dev/disk/by-uuid/01DC699B1D247C50";
        fsType = "ntfs-3g";
        options = ["nofail" "uid=1000" "gid=100" "umask=022"];
      };
      "/mnt/1tb_ssd" = {
        device = "/dev/disk/by-uuid/78174bbc-f96b-4325-87b2-db3cebdf345c";
        fsType = "ext4";
        options = ["nofail" "defaults"];
      };
      "/mnt/1tb_hdd" = {
        device = "/dev/disk/by-uuid/7E90B7D790B7945D";
        fsType = "ntfs-3g";
        options = ["nofail" "uid=1000" "gid=100" "umask=022"];
      };
    };
  };
}
