{self, ...}: {
  flake.userModules.max.nixosModule = {pkgs, ...}: {
    users.users.max = {
      isNormalUser = true;
      extraGroups = ["wheel" "audio" "rtkit" "realtime" "uinput" "libvirtd" "cdrom"];
      initialPassword = "nixos";
    };

    services.syncthing = {
      user = "max";
      dataDir = "/home/max";
      # key = "${config.sops.secrets."syncthing/key".path}";
      # cert = "${config.sops.secrets."syncthing/cert".path}";
    };

    environment.systemPackages = with pkgs; [
      self.packages.${system}.nh
      self.packages.${system}.max-git
    ];

    persist = {
      userDirs = [".nixos"];
    };
  };
}
