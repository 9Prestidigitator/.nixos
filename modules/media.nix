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
        jdk17 = pkgs.javaPackages.compiler.openjdk17;
      };
      myVlc = pkgs.vlc.override {inherit libbluray;};
    in
      with pkgs; [
        myVlc
        javaPackages.compiler.openjdk17
        jre17_minimal
        qbittorrent
        obs-studio
        zathura
        mpv
        makemkv
        handbrake
        ffmpeg
      ];
  };
}
