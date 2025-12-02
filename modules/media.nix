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

    environment.systemPackages = with pkgs; [
      qbittorrent
      mpv
      vlc
    ];
  };
}
