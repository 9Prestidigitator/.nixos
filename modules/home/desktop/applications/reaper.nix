{inputs, ...}: {
  flake.homeModules.reaper = {
    config,
    reaperActions,
    reaperMouse,
    reaperWindows,
    reaperAppearance,
    reaperLayout,
    ...
  }: let
    reaper-config = "reaper-flake";
  in {
    imports = [inputs.reaper-flake.homeModules.reaper];
    programs.reaper = {
      enable = true;
      configPath = "${config.xdg.configHome}/${reaper-config}";

      extensions = {
        reapack.enable = true;
        sws.enable = true;
      };

      swell.colortheme = {
        enable = true;
        preset = "stylix";
      };

      actions = {
        keyBindings = with reaperActions;
          bindings [
            (shortcut {
              shortcut = "J";
              command = 40285;
              actionName = "Track: Go to next track";
            })
            (shortcut {
              shortcut = "K";
              command = 40286;
              actionName = "Track: Go to previous track";
            })

            {
              modifierFlags = 255;
              keyCode = 2040;
              command = 989;
              section = sections.main;
              comment = "Main : Mousewheel : OVERRIDE DEFAULT : View: Scroll vertically (MIDI CC relative/mousewheel)";
            }
          ];
      };

      preferences = {
        windows = {
          tcpHelpBar = {
            informationDisplay = reaperWindows.tcpHelpBar.informationDisplay.cpuRamUseTimeSinceLastSave;
            showMouseEditingHelp = true;
          };
        };

        project = {
          backups = {
            whenSaving = {
              preservePreviousVersionAsRppBak = false;
              preserveAllPreviousVersionsInOneRppBak = false;
              preservePreviouslySavedVersionOfProjectAsRppBak = {
                enable = true;
                saveTimestampedBackupsToProjectBackupsSubdirectory = true;

                limitAutoSavedBackupsToMostRecent = {
                  enable = true;
                  count = 50;
                  unit = "copies";
                };
              };
            };

            autoSave = {
              autoSaveToTimestampedFileInProjectDirectory = {
                enable = true;
                saveBackupsToProjectAutoSavesSubdirectory = true;

                limitAutoSavedBackupsToMostRecent = {
                  enable = true;
                  count = 50;
                  unit = "copies";
                };
              };

              autoSaveUnsavedProjectsToTemporaryFile = true;
              autoSaveInterval = {
                minutes = 10;
                mode = "whenNotRecording";
              };
            };
          };
        };

        appearance = {
          trackControlPanels = {
            setTrackLabelBackgroundToCustomTrackColors = true;
            tintTrackPanelBackgrounds = false;

            showFxInserts = true;
            showSends = true;
            groupSendsWithFxInserts = false;
            groupFxParametersWithInserts = true;

            alignTcpControlsWhenTrackIconsOrFixedItemLanesAreUsed = true;
            trackGroupingIndicators = reaperAppearance.trackControlPanels.trackGroupingIndicators.ribbons;
            folderCollapseButtonCyclesTrackHeights = reaperAppearance.trackControlPanels.folderCollapseButtonCyclesTrackHeights.normalHidden;
            fixedLaneCollapseButtonChangesDisplay = reaperAppearance.trackControlPanels.fixedLaneCollapseButtonChangesDisplay.oneManyLanes;
          };

          zoomScrollOffset = {
            verticalZoomCenter = reaperAppearance.zoomScrollOffset.zoomCenter.vertical.lastSelectedTrack;
            maximumVerticalZoom = 0.90;
            envelopeLaneVerticalZoom = 0.5;
            horizontalZoomCenter = reaperAppearance.zoomScrollOffset.zoomCenter.horizontal.mouseCursor;

            limitHorizontalZoomScrollToProjectStart = true;
            verticalScrollStep = {
              unit = reaperAppearance.zoomScrollOffset.verticalScrollStep.units.trackHeight;
              trackHeight = 0.5;
              arrangeViewHeight = 0.1;
            };
            disableMousewheelVerticalZoomForTracksThatArePinnedInArrangeView = true;
            overlappingMediaItems = {
              offset = 100;
              drawAsOpaque = true;
              arrangeInCreationOrder = false;
            };
          };
        };

        editingBehavior = {
          mouseModifiers = {
            importedContexts = with reaperMouse; [
              contexts.arrange.middleDrag
              contexts.midiPianoRoll.leftClick
            ];

            contexts = with reaperMouse;
              merge [
                (set contexts.arrange.middleDrag modifiers.none (mouse 9))
                (set contexts.midiPianoRoll.leftClick modifiers.none (mouse 4))
              ];
          };
        };

        plugIns.reascript.python.enable = true;
      };

      layout = {
        dockers = {
          main = {
            id = reaperLayout.dock.mainDocker;
            position = "main";
          };

          left = {
            id = 1;
            position = "left";
            size = 320;
            preference = "0.85531396 1";
          };
        };

        mainWindow = {
          position = {
            x = 0;
            y = 0;
          };
          size = {
            width = 1600;
            height = 900;
          };
          state = reaperLayout.windowState.normal;
        };

        mixer = {
          visible = true;
          docked = true;
          docker = "main";
          position = {
            x = 0;
            y = 580;
          };
          size = {
            width = 1600;
            height = 320;
          };
          maximized = false;
        };

        masterMixer = {
          visible = false;
          docked = true;
          docker = "main";
          position = {
            x = 80;
            y = 80;
          };
          size = {
            width = 260;
            height = 500;
          };
        };

        transport = {
          visible = true;
          docked = true;
          docker = "main";
          dockPosition = reaperWindows.transport.topOfMainWindow;
        };

        dockedWindows = {
          explorer.docker = "left";
        };

        dockPreferences = {
          navigator = reaperLayout.dock.mainDocker;
        };

        rawSections = {
          reaper_explorer = {
            window_x = 80;
            window_y = 80;
            window_w = 900;
            window_h = 420;
          };
        };
      };
    };

    persist.directories = [".config/${reaper-config}"];
  };
}
