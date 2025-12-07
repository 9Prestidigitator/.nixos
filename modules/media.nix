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
  };
  myVlc = pkgs.vlc.override {inherit libbluray;};
  myVlcWithJava = myVlc.overrideAttrs (old: {
    buildInputs = (old.buildInputs or []) ++ [pkgs.javaPackages.compiler.openjdk17];
    propagatedBuildInputs = (old.propagatedBuildInputs or []) ++ [pkgs.javaPackages.compiler.openjdk17];
  });
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
      myVlcWithJava
      libaacs
      libbdplus
      makemkv
      handbrake
      ffmpeg
    ];
  };
}
