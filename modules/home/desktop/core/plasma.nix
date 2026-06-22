{inputs, ...}: {
  flake.homeModules.plasma = {
    imports = [inputs.plasma-manager.homeModules.plasma-manager];
    programs.plasma = {
      enable = true;

      kwin = {
        effects.blur.enable = false;
      };

      input.touchpads = [
        {
          name = "SYNA8006:00 06CB:CD8B Touchpad";
          vendorId = "06CB";
          productId = "CD8B";
          naturalScroll = true;
        }
      ];

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
        "kwinrc" = {
          "Plugins" = {
            "better_blur_dxEnabled" = true;
            "dynamic_workspacesEnabled" = true;
            "glassEnabled" = false;
          };
          "Effect-better-blur-dx" = {
            "BlurMatching" = false;
            "BlurNonMatching" = true;
            "BlurDecorations" = true;
          };
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
