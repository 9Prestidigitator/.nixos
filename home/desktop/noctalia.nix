{
  username,
  config,
  pkgs,
  inputs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  imports = [
    inputs.noctalia.homeModules.default
  ];

  programs.noctalia-shell = {
    enable = true;
    settings = {
      bar = {
        backgroundOpacity = 1;
        density = "default";
        floating = true;
        marginHorizontal = 0.35;
        marginVertical = 0.52;
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
              labelMode = "index";
              showNumbersOnlyWhenOccupied = true;
              showWorkspaceNumbers = false;
            }
          ];
          right = [
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
              id = "Volume";
            }
            {
              displayMode = "onhover";
              id = "WiFi";
            }
            {
              displayMode = "onhover";
              id = "Battery";
              warningThreshold = 30;
            }
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
        terminalCommand = "xterm -e";
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
        generateTemplatesForPredefined = true;
        manualSunrise = "06:30";
        manualSunset = "18:30";
        matugenSchemeType = "scheme-fruit-salad";
        predefinedScheme = "Monochrome";
        schedulingMode = "off";
        useWallpaperColors = false;
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
        backgroundOpacity = 0.78;
        colorizeIcons = false;
        displayMode = "auto_hide";
        enabled = true;
        floatingRatio = 0.58;
        monitors = [];
        onlySameOutput = true;
        pinnedApps = [];
        size = 1;
      };
      general = {
        animationDisabled = false;
        animationSpeed = 1;
        avatarImage = "/home/max/.face";
        compactLockScreen = false;
        dimmerOpacity = 0.8;
        enableShadows = false;
        forceBlackScreenCorners = false;
        language = "";
        lockOnSuspend = true;
        radiusRatio = 0.25;
        scaleRatio = 0.9;
        screenRadiusRatio = 1;
        shadowDirection = "bottom_right";
        shadowOffsetX = 2;
        shadowOffsetY = 3;
        showScreenCorners = false;
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
        enabled = false;
        forced = false;
        manualSunrise = "06:30";
        manualSunset = "18:30";
        nightTemp = "4000";
      };
      notifications = {
        backgroundOpacity = 1;
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
        backgroundOpacity = 1;
        enabled = true;
        location = "top_right";
        monitors = [];
        overlayLayer = true;
      };
      screenRecorder = {
        audioCodec = "opus";
        audioSource = "default_output";
        colorRange = "limited";
        directory = "/home/max/Videos";
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
            action = "hibernate";
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

      settingsVersion = 23;
      setupCompleted = true;
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
      templates = {
        alacritty = false;
        code = false;
        discord = false;
        enableUserTemplates = false;
        foot = false;
        fuzzel = false;
        ghostty = false;
        gtk = true;
        kcolorscheme = true;
        kitty = false;
        pywalfox = false;
        qt = true;
        spicetify = false;
        vicinae = false;
        walker = false;
        wezterm = false;
      };
      ui = {
        fontDefault = "Sans Serif";
        fontDefaultScale = 1;
        fontFixed = "Hack Nerd Font Mono";
        fontFixedScale = 1;
        panelBackgroundOpacity = 1;
        panelsAttachedToBar = true;
        settingsPanelAttachToBar = true;
        tooltipsEnabled = true;
      };
      wallpaper = {
        defaultWallpaper = "/home/max/.config/quickshell/Assets/Wallpaper/noctalia.png";
        directory = "/home/max/Pictures/Wallpapers";
        enableMultiMonitorDirectories = false;
        enabled = true;
        fillColor = "#000000";
        fillMode = "crop";
        hideWallpaperFilenames = false;
        monitors = [
          {
            directory = "/home/max/Pictures/Wallpapers";
            name = "Virtual-1";
            wallpaper = "/home/max/Pictures/Wallpapers/wallhaven_xee7k3.jpg";
          }
        ];
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
        wallhavenQuery = "portal";
        wallhavenResolutionHeight = "";
        wallhavenResolutionMode = "atleast";
        wallhavenResolutionWidth = "";
        wallhavenSorting = "date_added";
      };
    };
  };
}
