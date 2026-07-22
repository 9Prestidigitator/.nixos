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
        "noctalia/mpvpaper"
        "noctalia/notes"
        "avivbintangaringga/nix-monitor"
        "nzlov/daily-wallpaper"
        "rxtsel/portctl"
        "oldirtty/color_picker"
        "nightwatch75/file-search"
        "yocraft/web-launcher"
        "nightwatch75/todo"
        "dotnetrob/cat"
        "gustav0ar/drive-health"
        "alexander/game-launcher"
      ];
    };
    plugin_settings = {
      "noctalia/screen_recorder".video_codec = "hevc";
      "avivbintangaringga/nix-monitor" = {
        clean_command = "nh clean all";
        update_command = "nhre -u";
        panel_placement = "floating";
      };
      "noctalia/notes" = {
        notes_dir = "~/notes";
      };
    };
  };
}
