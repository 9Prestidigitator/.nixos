{
  flake.homeModules.mpd = {config, ...}: {
    services.mpd = {
      enable = true;
      musicDirectory = "${config.home.homeDirectory}/Music";
      network.listenAddress = "any";
      extraConfig = ''
        audio_output {
          type "pipewire"
          name "PipeWire"
        }
      '';
    };
  };
}
