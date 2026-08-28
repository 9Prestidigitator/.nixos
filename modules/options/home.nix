{
  flake.homeModules.global-options = {
    lib,
    config,
    ...
  }: {
    options = {
      persist = {
        directories = lib.mkOption {
          type = lib.types.listOf lib.types.anything;
          default = [];
          description = "Home directories to persist.";
        };

        files = lib.mkOption {
          type = lib.types.listOf lib.types.anything;
          default = [];
          description = "Home files to persist.";
        };
      };

      desktop = {
        explorer = {
          name = lib.mkOption {
            type = lib.types.nullOr (lib.types.enum ["nautilus" "dolphin"]);
            default = null;
            description = "Metadata option letting other home modules know what file explorer is being used.";
          };
          desktop = lib.mkOption {
            type = lib.types.nullOr lib.types.str;
            default = null;
          };
        };

        terminal = {
          name = lib.mkOption {
            type = lib.types.nullOr (lib.types.enum ["kitty" "ghostty"]);
            default = null;
            description = "Metadata option letting other home modules know what file terminal emulator is being used.";
          };
          desktop = lib.mkOption {
            type = lib.types.nullOr lib.types.str;
            default = null;
          };
        };

        browser = {
          name = lib.mkOption {
            type = lib.types.nullOr (lib.types.enum ["brave" "librewolf"]);
            default = null;
            description = "Metadata option letting other home modules know what file browser is being used.";
          };
          desktop = lib.mkOption {
            type = lib.types.nullOr lib.types.str;
            default = null;
          };
        };
      };
    };

    config = {
      desktop = {
        explorer.desktop =
          if config.desktop.explorer.name == null
          then null
          else
            {
              nautilus = "org.gnome.Nautilus";
              dolphin = "org.kde.dolphin";
            }.${
              config.desktop.explorer.name
            };

        terminal.desktop =
          if config.desktop.terminal.name == null
          then null
          else
            {
              kitty = "kitty";
              ghostty = "com.mitchellh.ghostty";
            }.${
              config.desktop.terminal.name
            };

        browser.desktop =
          if config.desktop.browser.name == null
          then null
          else
            {
              brave = "brave-browser";
              librewolf = "librewolf";
            }.${
              config.desktop.browser.name
            };
      };
    };
  };
}
