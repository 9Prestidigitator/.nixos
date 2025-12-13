{
  pkgs,
  lib,
  inputs,
  config,
  ...
}: {
  config = lib.mkIf config.media.enable {
    services.printing.drivers = [pkgs.hplipWithPlugin];

    environment = let
      libbluray = pkgs.libbluray.override {
        withAACS = true;
        withBDplus = true;
        withJava = true;
      };
      myVlc = pkgs.vlc.override {inherit libbluray;};
    in {
      systemPackages = with pkgs; [
        myVlc
        qbittorrent
        obs-studio
        zathura
        calibre
        anki
        obsidian
        easytag
        mpv
        makemkv
        handbrake
        ffmpeg
      ];
    };
  };
}
