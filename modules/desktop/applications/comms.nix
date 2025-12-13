{
  pkgs,
  lib,
  inputs,
  config,
  ...
}: {
  config = lib.mkIf config.desktop.comms.enable {
    environment.systemPackages = with pkgs; [
      (discord.override {
        withVencord = true;
      })
      signal-desktop
    ];
    home-manager.sharedModules = [
      inputs.nixcord.homeModules.nixcord
      {
        programs.nixcord = {
          enable = lib.mkDefault true;
          discord = {
            vencord.enable = true;
          };
          config = {
            plugins = {
              alwaysAnimate.enable = true;
              betterFolders.enable = true;
              blurNsfw.enable = true;
              pinDMs.enable = true;
              volumeBooster.enable = true;
              youtubeAdblock.enable = true;
            };
          };
        };
      }
    ];
  };
}
