{
  programs.plasma = {
    krunner.shortcuts.launch = "Meta+Space";

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
        "Lock Session" = ["Meta+Escape" "Screensaver"];
      };
      kwin = {
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
        "Show Desktop" = "Meta+Shift+D";
      };
      plasmashell = {
        "manage activities" = ["Meta+Z" "Show Activity Switcher"];
      };
    };
    # The #1 thing on my christmas wishlist is vim-like modal keybinds on kde plasma
  };
}
