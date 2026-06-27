{
  programs.noctalia.settings = {
    plugins = {
      source = [
        {
          auto_update = true;
          kind = "git";
          location = "https://github.com/noctalia-dev/official-plugins";
          name = "official";
        }
        {
          kind = "git";
          location = "https://github.com/noctalia-dev/community-plugins";
          name = "community";
        }
      ];
      enabled = [
        "noctalia/screen_recorder"
        "noctalia/translator"
        "noctalia/kaomoji"
        "noctalia/wallhaven"
      ];
    };
    plugin_settings = {
      "noctalia/screen_recorder".video_codec = "hevc";
    };
  };
}
