{inputs, ...}: {
  flake.homeModules.reaper = {
    config,
    reaperActions,
    reaperMouse,
    reaperWindows,
    reaperAppearance,
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
          transportDockPosition = reaperWindows.transport.topOfMainWindow;
          mixer.show = false;
        };

        project = {
          backups = {
            whenSaving = {
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

        mouse = {
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

        plugIns.reascript.python.enable = true;
      };
    };

    persist.directories = [".config/${reaper-config}"];
  };
}
