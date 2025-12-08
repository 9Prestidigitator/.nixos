{
  pkgs,
  lib,
  inputs,
  config,
  ...
}: {
  options = {
    media.enable = lib.mkEnableOption "Enable extra media packages";
  };

  config = lib.mkIf config.media.enable {
    services.printing.drivers = [pkgs.hplipWithPlugin];

    environment.systemPackages = let
      libbluray = pkgs.libbluray.override {
        withAACS = true;
        withBDplus = true;
        withJava = true;
      };
      myVlc = pkgs.vlc.override {inherit libbluray;};
    in
      with pkgs; [
        qbittorrent
        obs-studio
        zathura
        mpv
        myVlc
        javaPackages.compiler.openjdk17
        jre
        makemkv
        handbrake
        ffmpeg
      ];
  };
}
