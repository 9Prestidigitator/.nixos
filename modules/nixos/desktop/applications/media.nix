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
  };
}
