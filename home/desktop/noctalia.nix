{
  username,
  config,
  pkgs,
  inputs,
  lib,
  osConfig,
  ...
}: {
  imports = [
    inputs.noctalia.homeModules.default
  ];

  wayland.systemd.target = "niri.service";

  programs.noctalia-shell = {
    enable = true;
    systemd.enable = true;
    settings = {
      settingsVersion = 26;
      bar = {
        backgroundOpacity = lib.mkForce 0;
        density = "comfortable";
        floating = false;
        # marginHorizontal = 1.36;
        # marginVertical = 0;
        outerCorners = false;
        position = "left";
        showCapsule = false;
        widgets = {
          center = [];
          left = [
            {
              colorizeDistroLogo = false;
              customIconPath = "";
              icon = "";
              id = "ControlCenter";
              useDistroLogo = true;
            }
            {
              characterCount = 2;
              colorizeIcons = false;
              hideUnoccupied = true;
              id = "TaskbarGrouped";
              labelMode = "none";
              showNumbersOnlyWhenOccupied = true;
              showWorkspaceNumbers = false;
            }
          ];
          right =
            [
              {
                blacklist = [];
                colorizeIcons = false;
                drawerEnabled = true;
                id = "Tray";
                pinned = [];
              }
              {
                displayMode = "onhover";
                id = "Brightness";
              }
              {
                hideWhenZero = true;
                id = "NotificationHistory";
                showUnreadBadge = true;
              }
              {
                displayMode = "onhover";
                id = "Bluetooth";
              }
              {
                displayMode = "onhover";
                id = "Volume";
              }
              {
                displayMode = "onhover";
                id = "WiFi";
              }
            ]
            ++ lib.optional (osConfig.networking.hostName != "ink") {
              displayMode = "onhover";
              id = "Battery";
              warningThreshold = 30;
            }
            ++ [
              {
                customFont = "";
                formatHorizontal = "HH:mm ddd; MMM dd";
                formatVertical = "HH mm - dd MM";
                id = "Clock";
                useCustomFont = false;
                usePrimaryColor = true;
              }
            ];
        };
      };
      appLauncher = {
        customLaunchPrefix = "";
        customLaunchPrefixEnabled = false;
        enableClipboardHistory = true;
        pinnedExecs = [];
        position = "top_center";
        sortByMostUsed = true;
        terminalCommand = "kitty -e";
        useApp2Unit = false;
      };
      audio = {
        cavaFrameRate = 30;
        mprisBlacklist = [];
        preferredPlayer = "";
        visualizerQuality = "high";
        visualizerType = "linear";
        volumeOverdrive = false;
        volumeStep = 5;
      };
      battery = {
        chargingMode = 0;
      };
      brightness = {
        brightnessStep = 7;
        enableDdcSupport = false;
        enforceMinimum = true;
      };
      colorSchemes = {
        darkMode = true;
        generateTemplatesForPredefined = false;
        # manualSunrise = "06:30";
        # manualSunset = "18:30";
        # matugenSchemeType = "scheme-fruit-salad";
        # predefinedScheme = "Monochrome";
        predefinedScheme = "Nord";
        # schedulingMode = "off";
        # useWallpaperColors = false;
      };
      controlCenter = {
        cards = [
          {
            enabled = true;
            id = "profile-card";
          }
          {
            enabled = true;
            id = "shortcuts-card";
          }
          {
            enabled = true;
            id = "audio-card";
          }
          {
            enabled = false;
            id = "weather-card";
          }
          {
            enabled = true;
            id = "media-sysmon-card";
          }
        ];
        position = "close_to_bar_button";
        shortcuts = {
          left = [
            {
              id = "WiFi";
            }
            {
              id = "Bluetooth";
            }
            {
              id = "ScreenRecorder";
            }
            {
              id = "WallpaperSelector";
            }
          ];
          right = [
            {
              id = "Notifications";
            }
            {
              id = "PowerProfile";
            }
            {
              id = "KeepAwake";
            }
            {
              id = "NightLight";
            }
          ];
        };
      };
      dock = {
        enabled = true;
        backgroundOpacity = lib.mkForce 0;
        colorizeIcons = false;
        displayMode = "auto_hide";
        floatingRatio = 0.58;
        inactiveIndicators = true;
        deadOpacity = 0.4;
        monitors = [];
        onlySameOutput = false;
        pinnedApps = [
          "kitty"
          "org.gnome.Nautilus"
          "brave-browser"
          "steam"
          "discord"
          "com.bitwig.BitwigStudio"
        ];
        pinnedStatic = true;
        size = 1;
      };
      general = {
        animationDisabled = false;
        animationSpeed = 1.50;
        avatarImage = "${config.home.homeDirectory}/.face";
        dimmerOpacity = 0.4;
        enableShadows = false;
        forceBlackScreenCorners = false;
        language = "";
        iRadiusRatio = 1;
        radiusRatio = 1;
        scaleRatio = 1;
        screenRadiusRatio = 1;
        shadowDirection = "bottom_right";
        shadowOffsetX = 2;
        shadowOffsetY = 3;
        showScreenCorners = false;
        compactLockScreen = false;
        lockOnSuspend = true;
        showSessionButtonsOnLockScreen = false;
      };
      hooks = {
        darkModeChange = "";
        enabled = false;
        wallpaperChange = "";
      };
      location = {
        analogClockInCalendar = false;
        firstDayOfWeek = -1;
        name = "Washington D.C.";
        showCalendarEvents = true;
        showCalendarWeather = true;
        showWeekNumberInCalendar = false;
        use12hourFormat = false;
        useFahrenheit = false;
        weatherEnabled = true;
      };
      network = {
        wifiEnabled = true;
      };
      nightLight = {
        autoSchedule = true;
        dayTemp = "6500";
        enabled = true;
        forced = false;
        manualSunrise = "06:30";
        manualSunset = "18:30";
        nightTemp = "3000";
      };
      notifications = {
        backgroundOpacity = lib.mkForce 1;
        criticalUrgencyDuration = 15;
        enableKeyboardLayoutToast = true;
        enabled = true;
        location = "top_right";
        lowUrgencyDuration = 3;
        monitors = [];
        normalUrgencyDuration = 8;
        overlayLayer = true;
        respectExpireTimeout = false;
      };
      osd = {
        autoHideMs = 2000;
        backgroundOpacity = lib.mkForce 1;
        enabled = true;
        location = "top_right";
        monitors = [];
        overlayLayer = true;
      };
      screenRecorder = {
        audioCodec = "opus";
        audioSource = "default_output";
        colorRange = "limited";
        directory = "${config.home.homeDirectory}/Videos";
        frameRate = 60;
        quality = "very_high";
        showCursor = true;
        videoCodec = "h264";
        videoSource = "portal";
      };
      sessionMenu = {
        countdownDuration = 10000;
        enableCountdown = true;
        position = "center";
        powerOptions = [
          {
            action = "lock";
            countdownEnabled = true;
            enabled = true;
          }
          {
            action = "suspend";
            countdownEnabled = true;
            enabled = true;
          }
          {
            action = "reboot";
            countdownEnabled = true;
            enabled = true;
          }
          {
            action = "logout";
            countdownEnabled = true;
            enabled = true;
          }
          {
            action = "shutdown";
            countdownEnabled = true;
            enabled = true;
          }
        ];
        showHeader = true;
      };
      systemMonitor = {
        cpuCriticalThreshold = 90;
        cpuWarningThreshold = 80;
        criticalColor = "#ff5555";
        diskCriticalThreshold = 90;
        diskWarningThreshold = 80;
        memCriticalThreshold = 90;
        memWarningThreshold = 80;
        tempCriticalThreshold = 90;
        tempWarningThreshold = 80;
        useCustomColors = false;
        warningColor = "#8be9fd";
      };
      ui = {
        fontDefaultScale = 1;
        fontFixedScale = 1;
        panelBackgroundOpacity = lib.mkForce 0;
        panelsAttachedToBar = true;
        settingsPanelAttachToBar = false;
        tooltipsEnabled = true;
      };
      wallpaper = {
        directory = "${config.home.homeDirectory}/Pictures/Wallpapers";
        enableMultiMonitorDirectories = false;
        enabled = true;
        fillColor = "#000000";
        fillMode = "crop";
        hideWallpaperFilenames = false;
        overviewEnabled = false;
        panelPosition = "follow_bar";
        randomEnabled = false;
        randomIntervalSec = 300;
        recursiveSearch = false;
        setWallpaperOnAllMonitors = true;
        transitionDuration = 1500;
        transitionEdgeSmoothness = 0.05;
        transitionType = "random";
        useWallhaven = true;
        wallhavenCategories = "111";
        wallhavenOrder = "desc";
        wallhavenPurity = "100";
      };
    };
  };
}
