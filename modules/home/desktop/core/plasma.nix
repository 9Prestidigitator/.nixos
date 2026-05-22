{inputs, ...}: {
  flake.homeModules.plasma = let
    kittyForceBlurEffect = "kitty-force-blur";
  in {
    imports = [inputs.plasma-manager.homeModules.plasma-manager];

    xdg.dataFile."kwin/effects/${kittyForceBlurEffect}/metadata.json".text = builtins.toJSON {
      KPackageStructure = "KWin/Effect";
      KPlugin = {
        Id = kittyForceBlurEffect;
        Name = "Kitty Force Blur";
        Description = "Force KWin background blur for Kitty windows.";
        Category = "Appearance";
        Version = "1.0";
        License = "MIT";
        EnabledByDefault = false;
      };
      X-Plasma-API = "javascript";
    };

    xdg.dataFile."kwin/effects/${kittyForceBlurEffect}/contents/code/main.js".text = ''
      "use strict";

      function isKitty(window) {
          const windowClass = String(window.windowClass || "").toLowerCase();
          return windowClass.split(" ").indexOf("kitty") !== -1;
      }

      function forceBlur(window) {
          if (isKitty(window)) {
              window.setData(Effect.WindowForceBlurRole, true);
          }
      }

      effects.windowAdded.connect(forceBlur);
      for (const window of effects.stackingOrder) {
          forceBlur(window);
      }
    '';

    programs.plasma = {
      enable = true;

      kwin.effects.blur.enable = true;

      hotkeys.commands = {
        "launch-terminal" = {
          name = "Launch terminal";
          key = "Meta+Return";
          command = "kitty";
        };
      };

      configFile = {
        kdeglobals.General = {
          TerminalApplications = "kitty";
          TerminalService = "kitty.desktop";
        };
        kwinrc.Plugins."${kittyForceBlurEffect}Enabled" = true;
      };

      panels = [
        {
          location = "top";
          alignment = "center";
          height = 50;
          lengthMode = "fill";
          hiding = "normalpanel";
          opacity = "adaptive";
          floating = true;
          widgets = [
            {
              iconTasks = {
                launchers = [
                  "applications:kitty.desktop"
                  "applications:org.kde.dolphin.desktop"
                  "applications:brave-browser.desktop"
                ];
              };
            }

            "org.kde.plasma.panelspacer"

            {
              kickoff = {
                icon = "nix-snowflake-white";
                sortAlphabetically = true;
              };
            }

            "org.kde.plasma.panelspacer"

            {
              systemTray.items = {
                shown = [
                  "org.kde.plasma.volume"
                  "org.kde.plasma.networkmanagement"
                ];

                hidden = [
                  "org.kde.plasma.notifications"
                  "org.kde.plasma.clipboard"
                  "org.kde.plasma.brightness"
                  "org.kde.plasma.devicenotifier"
                  "org.kde.plasma.battery"
                ];
              };
            }
            {
              digitalClock = {
                time.format = "24h";
              };
            }
          ];
        }
      ];
    };
  };
}
