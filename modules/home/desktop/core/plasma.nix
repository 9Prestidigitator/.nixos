{inputs, ...}: {
  flake.homeModules.plasma = {
    pkgs,
    osConfig,
    lib,
    ...
  }: let
    isLaptop =
      if osConfig.networking.hostName == "ink"
      then false
      else true;
  in {
    imports = [inputs.plasma-manager.homeModules.plasma-manager];
    programs.plasma = {
      enable = true;

      kwin = {
        # virtualDesktops.rows = 10;
        effects.blur.enable = false;
        nightLight = {
          enable = true;
          mode = "automatic";
        };
      };

      krunner.shortcuts.launch = "Meta+Space";

      startup.startupScript.sunshine = {
        runAlways = true;
        text = ''
          sunshine=/run/wrappers/bin/sunshine
          if ! [ -x "$sunshine" ]; then
            sunshine=${pkgs.sunshine}/bin/sunshine
          fi

          if ! ${pkgs.procps}/bin/pgrep -x sunshine >/dev/null; then
            "$sunshine" &
          fi
        '';
      };

      workspace = let
        wallpaper-image = pkgs.fetchurl {
          url = "https://raw.githubusercontent.com/dharmx/walls/main/unsorted/a_black_and_white_swirly_pattern.jpg";
          hash = "sha256-XyyEJX4j6ZFhla6ay0rcYnGqAb5quWmwE9PmFkzWJk0=";
        };
      in {
        wallpaper = wallpaper-image;
      };

      kscreenlocker.appearance = let
        lockscreen-image = pkgs.fetchurl {
          url = "https://raw.githubusercontent.com/dharmx/walls/main/unsorted/a_black_background_with_purple_and_blue_spots.png";
          hash = "sha256-ngvhgrV+ph30C1HrqITKJEgWP6UtsXi7HFOZ6qnL3qg=";
        };
      in {
        wallpaper = lockscreen-image;
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
        "launch-monitor" = {
          name = "btop";
          key = "Ctrl+Shift+Esc";
          command = "kitty --title btop -e btop";
        };
      };

      shortcuts = {
        ksmserver = {
          # original: Lock Session=Meta+L\tScreensaver,Meta+L\tScreensaver,Lock Session
          "Lock Session" = ["Meta+Escape" "Screensaver"];
        };
        kwin = {
          # original: Window Close=Alt+F4,Alt+F4,Close Window
          "Window Close" = ["Meta+Q" "Close Window"];
          "Expose" = "Meta+Shift+O";
          "ExposeAll" = "Meta+O";
          "Walk Through Windows" = "Alt+Tab";
          "Walk Through Windows (Reverse)" = "Alt+Shift+Tab";
          "Walk Through Windows Alternative" = "Meta+Tab";
          "Walk Through Windows Alternative (Reverse)" = "Meta+Shift+Tab";
          "Switch Window Left" = "Meta+Alt+H";
          "Switch Window Down" = "Meta+Alt+J";
          "Switch Window Up" = "Meta+Alt+K";
          "Switch Window Right" = "Meta+Alt+L";
          "Switch to Screen to the Left" = "Meta+Shift+H";
          "Switch to Screen Below" = "Meta+Shift+J";
          "Switch to Screen Above" = "Meta+Shift+K";
          "Switch to Screen to the Right" = "Meta+Shift+L";
          "Switch One Desktop to the Left" = "Meta+H";
          "Switch One Desktop Down" = "Meta+J";
          "Switch One Desktop Up" = "Meta+K";
          "Switch One Desktop to the Right" = "Meta+L";
          "Window One Desktop to the Left" = "Meta+Ctrl+H";
          "Window One Desktop Down" = "Meta+Ctrl+J";
          "Window One Desktop Up" = "Meta+Ctrl+K";
          "Window One Desktop to the Right" = "Meta+Ctrl+L";
          "Window Maximize" = "Meta+U";
          "Window Minimize" = "Meta+D";
          "Window Above Other Windows" = "Meta+Ctrl+U";
          "Window Below Other Windows" = "Meta+Ctrl+D";
        };
        plasmashell = {
          # original: manage activities=Meta+Q,Meta+Q,Show Activity Switcher
          "manage activities" = ["Meta+Z" "Show Activity Switcher"];
        };
      };

      powerdevil = lib.mkIf (!isLaptop) {
        AC.autoSuspend.action = "nothing";
      };

      configFile = {
        kdeglobals.General = {
          TerminalApplications = "kitty";
          TerminalService = "kitty.desktop";
        };
        kwinrc = {
          Plugins = {
            "better_blur_dxEnabled" = true;
            "dynamic_workspacesEnabled" = true;
            # Been having issues with glass lately
            "glassEnabled" = false;
          };
          Effect-better-blur-dx = {
            "BlurMatching" = false;
            "BlurNonMatching" = true;
            "BlurDecorations" = true;
            "BlurMenus" = true;
            "BlurDocks" = true;
            "BlurStrength" = 9;
            "NoiseStrength" = 4;
          };
          Windows.RollOverDesktops = false;
          TabBox.DesktopMode = 1;
          TabBoxAlternative.DesktopMode = 0;
          Script-desktopchangeosd.PopupHideDelay = 200;
          Wayland = {
            VirtualKeyboardEnabled = true;
            EnablePrimarySelection = false;
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
                  "applications:steam.desktop"
                  "applications:cockos-reaper.desktop"
                ];
                behavior.showTasks.onlyInCurrentDesktop = false;
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
                  "Sunshine_dev.lizardbyte.app.Sunshine"
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
