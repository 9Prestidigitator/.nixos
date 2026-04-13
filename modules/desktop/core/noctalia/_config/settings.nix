{
  lib,
  config,
  isLaptop,
  ...
}: {
  programs.noctalia-shell = {
    enable = true;
    settings = {
      settingsVersion = 26;
      general = {
        animationDisabled = false;
        animationSpeed = 1.75;
        avatarImage = "${config.xdg.userDirs.pictures}/.face";
        dimmerOpacity = 0.4;
        enableShadows = true;
        forceBlackScreenCorners = false;
        language = "";
        iRadiusRatio = 1;
        radiusRatio = 1.4;
        scaleRatio = 1;
        screenRadiusRatio = 1;
        shadowDirection = "center";
        showScreenCorners = false;
        # Lock screen
        compactLockScreen = false;
        lockScreenAnimations = true;
        lockOnSuspend = true;
        clockStyle = "digital";
        passwordChars = true;
        enableLockScreenMediaControls = true;
        showSessionButtonsOnLockScreen = false;
        lockScreenBlur = 0;
        enableBlurBehind = true;
        allowPasswordWithFprintd = true;
      };
      appLauncher = {
        customLaunchPrefix = "";
        customLaunchPrefixEnabled = false;
        enableClipboardHistory = true;
        pinnedExecs = [];
        position = "bottom_center";
        sortByMostUsed = true;
        terminalCommand = "kitty -e";
        useApp2Unit = false;
        density = "compact";
        overviewLayer = true;
      };
      plugins = {
        autoUpdate = false;
      };
      audio = {
        volumeStep = 5;
        cavaFrameRate = 30;
        mprisBlacklist = [];
        preferredPlayer = "";
        visualizerQuality = "high";
        visualizerType = "linear";
        volumeOverdrive = false;
      };
      idle = {
        enabled = true;
        screenOffTimeout = 600;
        lockTimeout = 660;
        suspendTimeout =
          if isLaptop
          then 1800
          else 0;
      };
      battery = {
        chargingMode = 0;
      };
      brightness = {
        brightnessStep = 5;
        enableDdcSupport = false;
        enforceMinimum = false;
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
        enabled = true;
        autoSchedule = true;
        dayTemp = "6500";
        forced = false;
        manualSunrise = "06:30";
        manualSunset = "18:30";
        nightTemp = "3800";
      };
      notifications = {
        enabled = true;
        backgroundOpacity = lib.mkForce 1;
        enableMarkdown = true;
        criticalUrgencyDuration = 15;
        enableKeyboardLayoutToast = true;
        location = "top_right";
        lowUrgencyDuration = 3;
        normalUrgencyDuration = 8;
        overlayLayer = true;
        respectExpireTimeout = false;
      };
      osd = {
        enabled = true;
        autoHideMs = 2000;
        backgroundOpacity = lib.mkForce 1;
        location = "bottom";
        enabledTypes = [
          0
          1
          2
          3
          4
        ];
        overlayLayer = true;
      };
      screenRecorder = {
        audioCodec = "opus";
        audioSource = "default_output";
        colorRange = "limited";
        directory = "${config.xdg.userDirs.videos}";
        frameRate = 60;
        quality = "very_high";
        showCursor = true;
        videoCodec = "h264";
        videoSource = "portal";
      };
      sessionMenu = {
        enableCountdown = true;
        countdownDuration = 10000;
        position = "top_center";
        largeButtonsLayout = "single-row";
        powerOptions = [
          {
            action = "lock";
            countdownEnabled = true;
            enabled = true;
            keybind = "1";
          }
          {
            action = "suspend";
            countdownEnabled = true;
            enabled = true;
            keybind = "2";
          }
          {
            action = "reboot";
            countdownEnabled = true;
            enabled = true;
            keybind = "3";
          }
          {
            action = "logout";
            countdownEnabled = true;
            enabled = true;
            keybind = "4";
          }
          {
            action = "shutdown";
            countdownEnabled = true;
            enabled = true;
            keybind = "5";
          }
          {
            action = "hibernate";
            countdownEnabled = true;
            enabled = false;
            keybind = "6";
          }
        ];
        showHeader = false;
      };
      ui = {
        fontDefaultScale = 1;
        fontFixedScale = 1;
        panelBackgroundOpacity = lib.mkForce 0;
        translucentWidgets = true;
        panelsAttachedToBar = true;
        settingsPanelMode = "attached";
        tooltipsEnabled = true;
      };
      wallpaper = {
        enabled = true;
        directory = "${config.xdg.userDirs.pictures}/Wallpapers";
        hideWallpaperFilenames = false;
        panelPosition = "follow_bar";
        transitionType = "random";
        useWallhaven = true;
      };
    };
  };
}
