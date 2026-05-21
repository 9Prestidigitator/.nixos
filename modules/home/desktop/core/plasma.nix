{inputs, ...}: {
  flake.homeModules.plasma = {
    imports = [inputs.plasma-manager.homeModules.plasma-manager];
    programs.plasma = {
      enable = true;

      kwin.effects = {
        blur.enable = true;
        backgroundContrast.enable = true;
      };

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
