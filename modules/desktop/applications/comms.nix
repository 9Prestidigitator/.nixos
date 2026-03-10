{
  pkgs,
  lib,
  inputs,
  config,
  ...
}: {
  config = lib.mkIf config.desktop.comms.enable {
    environment.systemPackages = with pkgs; [
      signal-desktop
      element-desktop
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
              betterFolders.enable = false; # not working
              BlurNSFW.enable = true;
              PinDMs.enable = true;
              volumeBooster.enable = true;
              youtubeAdblock.enable = true;
              fakeNitro = {
                enable = true;
                enableEmojiBypass = true;
                enableStickerBypass = true;
              };
              fixYoutubeEmbeds.enable = true;
              gifPaste.enable = true;
            };
          };
        };
      }
    ];
  };
}
