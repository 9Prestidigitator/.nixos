{
  reaperGeneral,
  reaperAppearance,
  reaperMouse,
  ...
}: {
  programs.reaper = {
    preferences = {
      general = {
        startupSettings = {
          openProjectOnStartup = reaperGeneral.openProjectOnStartup.prompt;
          createNewProjectTabWhenOpeningMedia = true;
        };

        undo = {
          maximumUndoMemory = 512;
          saveHistoryWithProjectFiles = true;
        };
      };

      project = {
        projectLoading = {
          lookForProjectMediaInProjectDirectoryBeforeQualifiedPath = true;
        };
      };

      project = {
        trackSendDefaults = {
          trackVolumeFaderGain = -10.0;
          mainParentSend = true;
        };

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
          alignTcpControlsWhenTrackIconsOrFixedItemLanesAreUsed = true;

          showFxInserts = true;
          showSends = true;
          groupSendsWithFxInserts = false;
          groupFxParametersWithInserts = true;

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
  };
}
