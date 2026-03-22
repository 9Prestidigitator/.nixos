{
  lib,
  config,
  inputs,
  pkgs,
  ...
}: {
  programs.noctalia-shell = {
    plugins = {
      sources = [
        {
          enabled = true;
          name = "Official Noctalia Plugins";
          url = "https://github.com/noctalia-dev/noctalia-plugins";
        }
      ];
      states = {
        catwalk = {
          enabled = true;
          sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
        };
        privacy-indicator = {
          enabled = true;
          sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
        };
        screen-recorder = {
          enabled = true;
          sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
        };
        timer = {
          enabled = true;
          sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
        };
        currency-exchange = {
          enabled = true;
          sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
        };
        keybind-cheatsheet = {
          enabled = true;
          sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
        };
        unicode-picker = {
          enabled = true;
          sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
        };
        custom-commands = {
          enabled = true;
          sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
        };
        web-search = {
          enabled = true;
          sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
        };
        kaomoji-provider = {
          enabled = true;
          sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
        };
        niri-overview-launcher = {
          enabled = false;
          sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
        };
        mpd = {
          enabled = true;
          sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
        };
        notes-scratchpad = {
          enabled = true;
          sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
        };
        todo = {
          enabled = true;
          sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
        };
        screen-toolkit = {
          enabled = true;
          sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
        };
        assistant-panel = {
          enabled = true;
          sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
        };
        custom-sticker = {
          enabled = true;
          sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
        };
        clipper = {
          enabled = true;
          sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
        };
        kde-connect = {
          enabled = true;
          sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
        };
      };
      version = 1;
    };

    pluginSettings = {
      catwalk = {
        minimumThreshold = 10;
        hideBackground = true;
      };
      timer = {
        compactMode = false;
        defaultDuration = 0;
      };
      web-search = {
        search_engine = "Brave";
        show_suggestions = true;
        max_results = 5;
      };
      custom-commands = {
        commands = [
          {
            name = "notes";
            command = "kitty --title Notes -e sh -c 'cd ~/notes && nix develop -c sh -c nvim'";
            icon = "notes";
          }
          {
            name = "tmux";
            command = "kitty --title tmux bash -lc 'tmux a || tmux'";
            icon = "terminal-2";
          }
        ];
      };
      assistant-panel = {
        ai = {
          provider = "openai_compatible";
          models = {
            openai_compatible = "gpt-5.4-mini";
          };
          temperature = 0.5;
          systemPrompt = "You are a helpful assistant integrated into a NixOS desktop shell. Be concise and helpful.";
          openaiLocal = false;
          openaiBaseUrl = "https://api.openai.com/v1";
          model = "gpt-5.4-mini";
        };
        translator = {
          backend = "google";
          deeplApiKey = "";
          realTimeTranslation = true;
        };
        maxHistoryLength = 100;
        panelDetached = false;
        panelPosition = "right";
        panelHeightRatio = 0.85;
        panelWidth = 601;
        attachmentStyle = "connected";
        scale = 1;
      };
    };
  };
}
