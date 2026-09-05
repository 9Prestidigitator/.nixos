{
  flake.nixosModules.media = {pkgs, ...}: {
    services.printing.drivers = [
      (pkgs.hplipWithPlugin.override {
        python3Packages = pkgs.python313Packages;
      })
    ];

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
      imv
      makemkv
      handbrake
      ffmpeg
      rmpc
      cava
      yt-dlp
    ];

    xdg.mime.defaultApplications = {
      "application/pdf" = ["org.pwmt.zathura.desktop"];
      "audio/mpeg" = ["mpv.desktop"];
      "audio/flac" = ["mpv.desktop"];
      "audio/ogg" = ["mpv.desktop"];
      "audio/wav" = ["mpv.desktop"];
      "audio/x-wav" = ["mpv.desktop"];
      "audio/mp3" = ["mpv.desktop"];
      "audio/x-mp3" = ["mpv.desktop"];
      "video/mp4" = ["mpv.desktop"];
      "video/webm" = ["mpv.desktop"];
      "video/x-matroska" = ["mpv.desktop"];
      "video/x-msvideo" = ["mpv.desktop"];
      "image/png" = ["imv.desktop"];
      "image/jpg" = ["imv.desktop"];
      "image/jpeg" = ["imv.desktop"];
    };

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
