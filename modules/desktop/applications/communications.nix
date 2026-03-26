{inputs, ...}: {
  flake.nixosModules.communications = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      signal-desktop
      element-desktop
    ];
  };

  flake.homeModules.communications = {
    imports = [inputs.nixcord.homeModules.nixcord];
    programs.nixcord = {
      enable = true;
      discord = {
        vencord.enable = true;
      };
      config = {
        plugins = {
          alwaysAnimate.enable = true;
          betterFolders.enable = false; # not working
          BlurNSFW.enable = true;
          fakeNitro = {
            enable = true;
            enableEmojiBypass = true;
            enableStickerBypass = true;
          };
          fixYoutubeEmbeds.enable = true;
          gifPaste.enable = true;
          PinDMs.enable = true;
          volumeBooster.enable = true;
          youtubeAdblock.enable = true;
        };
      };
    };
  };
}
