{
  pkgs,
  lib,
  inputs,
  config,
  ...
}: {
  options = {
    comms.enable = lib.mkEnableOption "Enable communications applications";
  };

  config = lib.mkIf config.comms.enable {
    environment.systemPackages = with pkgs; [
      (discord.override {
        withVencord = true;
      })
      signal-desktop
    ];
  };
}
