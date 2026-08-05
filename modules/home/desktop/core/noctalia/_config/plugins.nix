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
        "alexander/game-launcher"
        "avivbintangaringga/nix-monitor"
        "blackbartblues/audio-switcher"
        "cleboost/anilist"
        "dotnetrob/cat"
        "dunarand/tmux-provider"
        "elijaharch/wl-screen-mirror"
        "gustav0ar/drive-health"
        "icefish/phone-connect"
        "kenn/keybind-cheatsheet"
        "nightwatch75/file-search"
        "nightwatch75/todo"
        "noctalia/screen_recorder"
        "noctalia/kaomoji"
        "noctalia/mpvpaper"
        "noctalia/notes"
        "noctalia/timer"
        "noctalia/translator"
        "noctalia/wallhaven"
        "nzlov/daily-wallpaper"
        "oldirtty/color_picker"
        "rxtsel/portctl"
        "tadomika_ari/w-engine"
        "yocraft/qrcode"
        "yocraft/web-launcher"
        "yuuto/calculator"
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
