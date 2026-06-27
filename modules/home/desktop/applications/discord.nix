{inputs, ...}: {
  flake.homeModules.discord = {
    imports = [inputs.nixcord.homeModules.nixcord];
    programs.nixcord = {
      enable = true;
      discord = {
        vencord.enable = true;
      };
      config = {
        transparent = true;
        plugins = {
          accountPanelServerProfile.enable = true;
          alwaysAnimate.enable = true;
          betterFolders.enable = true;
          blurNsfw.enable = true;
          callTimer.enable = true;
          copyFileContents.enable = true;
          copyUserUrls.enable = true;
          experiments.enable = true;
          fakeNitro = {
            enable = true;
            enableEmojiBypass = true;
            enableStickerBypass = true;
          };
          fixYoutubeEmbeds.enable = true;
          gifPaste.enable = true;
          noMosaic.enable = true;
          notificationVolume.enable = true;
          pinDms.enable = true;
          volumeBooster.enable = true;
          relationshipNotifier.enable = true;
          serverInfo.enable = true;
          spotifyCrack.enable = true;
          showHiddenChannels.enable = true;
          showHiddenThings.enable = true;
          youtubeAdblock.enable = true;
          whoReacted.enable = true;
        };
      };
    };

    persist.directories = [
      ".cache/discord"
      ".config/discord"
    ];
  };
}
