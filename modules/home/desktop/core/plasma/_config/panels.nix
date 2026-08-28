{
  lib,
  config,
  osConfig,
  options,
  ...
}: {
  programs.plasma = {
    panels = [
      {
        screen = "all";
        location = "top";
        alignment = "center";
        height = 40;
        lengthMode = "fill";
        hiding = "normalpanel";
        opacity = "adaptive";
        floating = true;
        widgets = [
          {
            iconTasks = {
              launchers = [];
              behavior = {
                grouping.method = "none";
                showTasks = {
                  onlyInCurrentDesktop = true;
                  onlyInCurrentScreen = true;
                };
              };
            };
          }

          "org.kde.plasma.panelspacer"

          {
            kickoff = {
              icon = "nix-snowflake-white";
              sortAlphabetically = true;
              showButtonsFor = "session";
              settings.General = {
                switchCategoryOnHover = true;
              };
            };
          }

          "org.kde.plasma.panelspacer"

          {
            systemTray.items = {
              shown = [
                "org.kde.plasma.notifications"
                "org.kde.plasma.bluetooth"
                "org.kde.plasma.volume"
                "org.kde.plasma.networkmanagement"
                "org.kde.plasma.battery"
              ];

              hidden = [
                "org.kde.plasma.clipboard"
                "org.kde.plasma.brightness"
                "org.kde.plasma.devicenotifier"
                "Discover Notifier_org.kde.DiscoverNotifier"
                "org.kde.merkuro.contact.applet"
                "Sunshine_dev.lizardbyte.app.Sunshine"
                "spotify-client"
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

      {
        screen = "all";
        location = "bottom";
        alignment = "center";
        height = 50;
        lengthMode = "fit";
        hiding = "dodgewindows";
        opacity = "adaptive";
        floating = true;

        widgets = [
          {
            iconTasks = {
              launchers =
                lib.optional (options ? desktop.terminal.name
                  && config.desktop.terminal.name
                  != null)
                "applications:${config.desktop.terminal.desktop}.desktop"
                ++ [
                  "applications:org.kde.dolphin.desktop"
                ]
                ++ lib.optional (options ? desktop.browser.name
                  && config.desktop.browser.name
                  != null)
                "applications:${config.desktop.browser.desktop}.desktop"
                ++ lib.optional osConfig.programs.steam.enable "applications:steam.desktop"
                ++ lib.optional (options ? programs.reaper.enable && config.programs.reaper.enable) "applications:cockos-reaper.desktop";

              appearance = {
                fill = false;
                iconSpacing = "medium";
                showTooltips = true;
              };

              behavior = {
                sortingMethod = "manually";
                minimizeActiveTaskOnClick = true;
                middleClickAction = "newInstance";
                grouping.method = "byProgramName";
                showTasks = {
                  onlyInCurrentDesktop = false;
                  onlyInCurrentScreen = false;
                };
              };
            };
          }
        ];
      }
    ];
  };
}
