{
  pkgs,
  lib,
  inputs,
  config,
  ...
}: let
  libbluray = pkgs.libbluray.override {
    withAACS = true;
    withBDplus = true;
    withJava = true;
  };
  myVlc = pkgs.vlc.override {inherit libbluray;};
in {
  options = {
    media.enable = lib.mkEnableOption "Enable extra media packages";
  };

  config = lib.mkIf config.media.enable {
    services.printing.drivers = [pkgs.hplipWithPlugin];

    environment.systemPackages = with pkgs; [
      qbittorrent
      mpv
      obs-studio
      myVlc
      javaPackages.compiler.openjdk17
      jre
      makemkv
      handbrake
      ffmpeg
      zathura
    ];
  };
}
