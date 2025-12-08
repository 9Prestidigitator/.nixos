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

    programs.java.enable = true;

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
        mpv
        makemkv
        handbrake
        ffmpeg
      ];
    };
  };
}
