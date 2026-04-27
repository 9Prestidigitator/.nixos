{
  flake.nixosModules.video-editing = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      davinci-resolve
      kdePackages.kdenlive
      blender
    ];
  };
}
