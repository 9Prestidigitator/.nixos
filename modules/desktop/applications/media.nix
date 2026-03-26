{inputs, ...}: {
  flake-file.inputs.spicetify-nix.url = "github:Gerg-L/spicetify-nix";

  flake.nixosModules.media = {pkgs, ...}: {
    services.printing.drivers = [pkgs.hplipWithPlugin];
    environment = let
      libbluray = pkgs.libbluray.override {
        withAACS = true;
        withBDplus = true;
        withJava = true;
      };
      myVlc = pkgs.vlc.override {inherit libbluray;};
    in {
      systemPackages = with pkgs; [
        myVlc
        qbittorrent
        obs-studio
        zathura
        calibre
        anki
        obsidian
        easytag
        mpv
        makemkv
        handbrake
        ffmpeg
        rmpc
        cava
        cantata
        yt-dlp
      ];
    };

    flake.homeModules.general = {pkgs, lib, ...}: {
      imports = [inputs.spicetify-nix.homeManagerModules.default];
      programs.spicetify = let
        spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
      in {
        enable = lib.mkDefault true;
        theme = spicePkgs.themes.hazy;
        enabledExtensions = with spicePkgs.extensions; [
          adblock
          hidePodcasts
        ];
        enabledCustomApps = with spicePkgs.apps; [
          newReleases
          ncsVisualizer
        ];
      };
    };
  };
}
