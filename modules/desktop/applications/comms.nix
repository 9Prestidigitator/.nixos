{
  pkgs,
  lib,
  inputs,
  config,
  ...
}: {
  config = lib.mkIf config.comms.enable {
    environment.systemPackages = with pkgs; [
      (discord.override {
        withVencord = true;
      })
      signal-desktop
    ];
  };
}
