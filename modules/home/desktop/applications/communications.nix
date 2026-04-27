{inputs, ...}: {
  flake.homeModules.communications = {
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
          BlurNSFW.enable = true;
          callTimer.enable = true;
          copyFileContents.enable = true;
          CopyUserURLs.enable = true;
          experiments.enable = true;
          fakeNitro = {
            enable = true;
            enableEmojiBypass = true;
            enableStickerBypass = true;
          };
          fixYoutubeEmbeds.enable = true;
          friendsSince.enable = true;
          gifPaste.enable = true;
          noMosaic.enable = true;
          notificationVolume.enable = true;
          PinDMs.enable = true;
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
  };
}
