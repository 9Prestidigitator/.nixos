{inputs, ...}: {
  flake.homeModules.plasma = {
    imports = [inputs.plasma-manager.homeModules.plasma-manager];
    programs.plasma = {
      enable = true;
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
          location = "bottom";
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

            "org.kde.plasma.systemtray"
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
