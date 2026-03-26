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
      pkgsStable.obsidian
      easytag
      mpv
      # makemkv # derivation is broken
      handbrake
      ffmpeg
      rmpc
      cava
      cantata
      yt-dlp
    ];
  };

  flake.homeModules.general = {
    pkgs,
    lib,
    ...
  }: {
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
}
