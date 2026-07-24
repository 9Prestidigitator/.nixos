{
  reaperWindows,
  reaperLayout,
  ...
}: {
  programs.reaper = {
    layout = {
      docks = {
        bottom = {
          id = 3;
          position = "bottom";
          selectedPanel = "mixer";
        };

        left = {
          id = 2;
          position = "left";
          size = 395;
          selectedPanel = "explorer";
        };

        right = {
          id = 1;
          position = "right";
          selectedPanel = "mastermixer";
        };
      };

      transport = {
        visible = true;
        dockPosition = reaperWindows.transport.topOfMainWindow;
      };

      masterMixer = {
        visible = true;
        docked = true;
        dock = "right";
        tabOrder = 0.0;
      };

      mixer = {
        visible = false;
        docked = true;
        dock = "bottom";
        tabOrder = 0.0;
      };

      panels.explorer = {
        id = "explorer";
        section = "reaper_sexplorer";
        keyStyle = "window";
        visible = false;
        docked = true;
        dock = "left";
        tabOrder = 0.5;
      };
    };

    windows = {
      tcpHelpBar = {
        informationDisplay = reaperWindows.tcpHelpBar.informationDisplay.cpuRamUseTimeSinceLastSave;
        showMouseEditingHelp = true;
      };
      mixer.master.showInDockerOrWindow = true;
    };
  };
}
