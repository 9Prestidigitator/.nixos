{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    musicprod.enable = lib.mkEnableOption "Enables music production configuration.";
  };

  config = lib.mkIf config.musicprod.enable {
    home.packages = with pkgs; [
      yabridge
      yabridgectl
    ];
  };
}
