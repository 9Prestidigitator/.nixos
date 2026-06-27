{pkgs, ...}: {
  programs.plasma = {
    enable = true;

    kwin = {
      # virtualDesktops.rows = 3;
      effects.blur.enable = false;
      nightLight = {
        enable = true;
        mode = "automatic";
      };
    };

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
        Windows = {
          RollOverDesktops = false;
          ActivationDesktopPolicy = "SwitchToOtherDesktop";
          FocusStealingPreventionLevel = 0;
          PerOutputVirtualDesktops = true;
        };
        TabBox.DesktopMode = 1;
        TabBoxAlternative.DesktopMode = 0;
        Script-desktopchangeosd.PopupHideDelay = 200;
        Wayland = {
          VirtualKeyboardEnabled = true;
          EnablePrimarySelection = false;
        };
      };
    };
  };
}
