{inputs, ...}: {
  flake.nixosModules.media = {pkgs, ...}: let
    pkgsStable = import inputs.nixpkgs-stable {
      system = pkgs.stdenv.hostPlatform.system;
      config = {
        allowUnfree = true;
      };
    };
  in {
    services.printing.drivers = [pkgs.hplipWithPlugin];
    environment.systemPackages = with pkgs; [
      libbluray-full
      vlc
      qbittorrent
      obs-studio
      zathura
      calibre
      anki
      obsidian
      easytag
      mpv
      pkgsStable.makemkv
      handbrake
      ffmpeg
      rmpc
      cava
      yt-dlp
    ];

    persist.userDirs = [
      ".config/aacs"
      ".config/obs-studio"
      ".config/obsidian"
      ".config/vlc"
      ".config/calibre"
      ".cache/calibre"
      "Calibre Library"
      ".local/share/calibre-ebook.com"
      ".local/share/vlc"
      ".local/share/zathura"
      ".MakeMKV"
      ".config/MakeMKV"
      ".config/qBittorrent"
      ".cache/qBittorrent"
      ".local/share/qBittorrent"
    ];
  };
}
