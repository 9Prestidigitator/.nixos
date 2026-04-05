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
      pkgsStable.makemkv
      handbrake
      ffmpeg
      rmpc
      cava
      yt-dlp
    ];
  };

  flake.homeModules.media = {pkgs, ...}: {
    imports = [inputs.spicetify-nix.homeManagerModules.default];
    programs.spicetify = let
      spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
    in {
      enable = true;
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
    programs.mpv = {
      enable = true;

      scripts = with pkgs.mpvScripts; [
        uosc
        thumbfast
      ];

      config = {
        keep-open = "yes";
        ao = "pipewire";

        osd-bar = "no";

        layout = "bottombar";
        vidscale = false;
        scalewindowed = 1.35;
        scalefullscreen = 1.0;

        seekbarstyle = "knob";
        seekbarhandlesize = 0.9;

        seekrangestyle = "line";
        seekrangeseparate = true;
        seekrangealpha = 30;
      };
      bindings = {
        "SPACE" = "cycle pause";
        q = "quit";

        h = "seek -5";
        l = "seek 5";
        H = "seek -60";
        L = "seek 60";

        j = "playlist-next";
        k = "playlist-prev";

        "=" = "add speed 0.05";
        "-" = "add speed -0.05";
        "0" = "set speed 1.0";

        "+" = "multiply pitch 1.05946309436";
        "_" = "multiply pitch 0.94387431268";

        "\\" = "set pitch 1.0";

        "Alt+3" = "set pitch 0.9818181818; show-text \"A=432\"";
        "Alt+4" = "set pitch 1.0; show-text \"pitch reset\"";
        "Alt+5" = "set pitch 1.0185185185; show-text \"A=440\"";
      };
    };
  };
}
