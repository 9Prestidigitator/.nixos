{
  flake.nixosModules.video-editing = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      davinci-resolve
      kdePackages.kdenlive
      blender
    ];

    persist = {
      userDirs = [
        ".config/blender"
        ".cache/kdenlive"
        ".local/share/kdenlive"
        ".local/state/kdenlivestaterc"
      ];
      userFiles = [
        ".config/kdenliverc"
        ".config/kdenlive-layoutsrc"
      ];
    };
  };
}
