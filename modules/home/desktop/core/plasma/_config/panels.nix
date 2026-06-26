{
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
              launchers = [
                "applications:kitty.desktop"
                "applications:org.kde.dolphin.desktop"
                "applications:brave-browser.desktop"
                "applications:steam.desktop"
                "applications:cockos-reaper.desktop"
              ];
              behavior.showTasks.onlyInCurrentDesktop = true;
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
                "org.kde.plasma.bluetooth"
                "org.kde.plasma.volume"
                "org.kde.plasma.networkmanagement"
                "org.kde.plasma.battery"
              ];

              hidden = [
                "org.kde.plasma.notifications"
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
        hiding = "dodgewindows"; # or "autohide"
        opacity = "adaptive";
        floating = true;

        widgets = [
          {
            iconTasks = {
              launchers = [
                "applications:kitty.desktop"
                "applications:org.kde.dolphin.desktop"
                "applications:brave-browser.desktop"
                "applications:steam.desktop"
                "applications:cockos-reaper.desktop"
              ];

              appearance = {
                fill = false;
                iconSpacing = "medium";
                showTooltips = true;
              };

              behavior = {
                sortingMethod = "manually";
                grouping.method = "byProgramName";
                minimizeActiveTaskOnClick = true;
                middleClickAction = "newInstance";
                showTasks.onlyInCurrentDesktop = false;
                showTasks.onlyInCurrentScreen = false;
              };
            };
          }
        ];
      }
    ];
  };
}
